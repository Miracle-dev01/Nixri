{
  opener = {
    zen = [
      {
        run = "zen \"$@\"";
        orphan = true;
        desc = "Zen Browser";
      }
    ];

    sioyek = [
      {
        run = "sioyek \"$@\"";
        orphan = true;
        desc = "Sioyek PDF Reader";
      }
    ];
    
    chromium = [
       {
        run = "chromium \"$@\"";
        orphan = true;
        desc = "Chromium Browser";
           }
        ];
  };

  open = {
    prepend_rules = [
      {
        mime = "application/pdf";
        use = [
            "zen"
          "sioyek"
          "chromium"
          "reveal"
        ];
      }
    ];
  };
}
