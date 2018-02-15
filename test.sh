if [[ -f '/etc/lsb-release' ]]; then
  distFile=`cat /etc/lsb-release`;
elif [[ -f '/etc/os-release' ]]; then
  distFile=`cat /etc/os-release`;
else
  distFile='No release file found';
fi

dist='unknown';
# Testing for ubermix, I'm not sure if it starts with capital u,
# so bermix should work
if [[ ${distFile} = *'bermix'* ]]; then
  dist='ubermix';
# The same as bermix for ubermix, aspbian should work for raspbian
elif [[ ${distFile} = *'aspbian'* ]]; then
  dist='raspbian';
elif [[ ${distFile} = *'elementary'* ]]; then
  dist='raspbian';
fi
echo ${dist};