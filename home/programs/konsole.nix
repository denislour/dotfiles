{ pkgs, ... }: {
  home.packages = with pkgs; [ konsole ];

  home.file.".local/share/konsole/csi-u.keytab".text = ''
    key Return +Shift : "\E[13;2u"
  '';
}
