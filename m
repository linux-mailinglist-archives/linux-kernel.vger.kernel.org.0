Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A323D187B53
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 09:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQIcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 04:32:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40933 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:32:33 -0400
Received: by mail-io1-f67.google.com with SMTP id d8so20044769ion.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/xn2plA996CBuz8fNTsQFvTz+x1vxgYWj19xP/2JoI=;
        b=B6zNlUZaje7yn8WOECf9nOmrVokHu0nwyb70nNUdoHHnvOTC3AYr84t88lHk1ZHPuD
         L0hRZtW+1ETKe9rIRDW23bA3drVA8QfRajrwykuvuZwjq5B0ZKzY6/Qr6v1hJuCOopTM
         2d6clWvNreERpL+caCMTigob7Lb5VGTVAI52A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/xn2plA996CBuz8fNTsQFvTz+x1vxgYWj19xP/2JoI=;
        b=JBagGKhQqzBFmdVdtIYA4htYgMucPzpg/AAtJDLm9FbwCCH8OSNfs8b47mwC8Dt+jC
         hoYk6kIRmoXF4XFv3Ilesi3b9mfnpZh263eVCWJVWoiZEPo9qKhUJKevS+ZhsdlKm6Z6
         vzjlo2G3okaJfRY3a/tDNLoqDHxEhcKojKyRtCGAgVwXk8D9ZKqWqzw6bHo7c5rgPA09
         DbldV/IyAR5826tBEgt3JFTmXISn4+jryzvRcbEGiXi+1An/YcRecMzVEymqKyGT/i/L
         iy4PaEsnLU0JY/fiQdALXhjqE66L28pzx6YBLUsmXLkm4fGd0c7pNbMxSZ3Ps6k/AE/Y
         Gatg==
X-Gm-Message-State: ANhLgQ0vAg1WVugQ4JiGGJTjTHudS0I3zD68U6NxbzynVpCz8E9WvHCS
        Rxos2pwpa2bbyFB0PxV1HA3drFagjOKUbMls4mtSSw==
X-Google-Smtp-Source: ADFU+vuwgJ63PydvmMkvfAPukN0HBfPURkphAQ8Fr0g6T/pnVNRT0ZBZlqvaPwgDIPmP8AZ3ndzLGh+g2mcNzEiC0ZA=
X-Received: by 2002:a05:6638:a9b:: with SMTP id 27mr4116136jas.70.1584433952862;
 Tue, 17 Mar 2020 01:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200225094437.4170502-0-mholenko@antmicro.com>
 <20200225094437.4170502-2-mholenko@antmicro.com> <20200225165750.GA15779@bogus>
In-Reply-To: <20200225165750.GA15779@bogus>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 17 Mar 2020 09:32:21 +0100
Message-ID: <CAPk366Qg-U8xUsvTjeMfzYs8tg_m4wO5Ghg0FseRgbdOfV8FCA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: soc: document LiteX SoC Controller bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 5:57 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 25 Feb 2020 09:46:45 +0100, Mateusz Holenko wrote:
> > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> >
> > Add documentation for LiteX SoC Controller bindings.
> >
> > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > ---
> >
> > Notes:
> >     This commit has been introduced in v3 of the patchset.
> >
> >  .../soc/litex/litex,soc_controller.yaml       | 46 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 +++
> >  2 files changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> warning: no schema found in file: Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml: ignoring, error parsing file
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-doc-validate", line 35, in check_doc
>     testtree = dtschema.load(filename, line_number=line_number, duplicate_keys=False)
>   File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 513, in load
>     return yaml.load(f.read())
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
>     return constructor.get_single_data()
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
>     node = self.composer.get_single_node()
>   File "_ruamel_yaml.pyx", line 718, in _ruamel_yaml.CParser.get_single_node
> ruamel.yaml.composer.ComposerError: expected a single document in the stream
>   in "<unicode string>", line 1, column 1
> but found another document
>   in "<unicode string>", line 2, column 1
>
> During handling of the above exception, another exception occurred:
>
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-doc-validate", line 74, in <module>
>     ret = check_doc(args.yamldt)
>   File "/usr/local/bin/dt-doc-validate", line 40, in check_doc
>     print(filename + ":", exc.path[-1], exc.message)
> AttributeError: 'ComposerError' object has no attribute 'path'
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/soc/litex/litex,soc_controller.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/soc/litex/litex,soc_controller.example.dts] Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1243930
> Please check and re-submit.

Thanks for spotting this.

It looks like the first line of the document is broken - it should be
a comment with a license descriptor, but the initial characters are
missing.

I'll fix this and resubmit the whole patchset after addressing all
other remarks.


-- 
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
