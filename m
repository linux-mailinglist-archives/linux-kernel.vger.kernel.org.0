Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404A9430EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 22:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfFLUUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 16:20:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46500 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbfFLUUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:20:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so7820725pgr.13;
        Wed, 12 Jun 2019 13:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l2jpWw1j7PiDPqqEwaBU8j5otiTiwOJHY3AXn3MncvA=;
        b=NbKAHivcBjreOyENMevm1S7KsAqFun7vu3wu7COb+JBP0nOxLqNjJVLZ2vZKe8Po7l
         qyanv67gv6nh6IktJnXrj+umleFlditpZho7e84DNvbNvybsVuqnnBBccFBwjhK2QWvk
         IyoT/W2bcCaO3jvyhN/63qu8Fj7SIZx/axKNIzJMmVVMsnpC7J2L/fb/jCMUKUQ/AGoU
         tSMneMunVPT/WOuC39So4cnu6M7PPktbnc16NdXuu+/Dz7nibERTfe7iDDOkwgkvG9X1
         H/S3KJ6Ozp9+bZH4g3x+XM8wSqbwkhhGagLOdlS7++d3JVAXBqZNh9M/Bf7WeShWoOXl
         medw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l2jpWw1j7PiDPqqEwaBU8j5otiTiwOJHY3AXn3MncvA=;
        b=P3639cvwYm/32z9UPqRVN9XfW/N1JpkfHkzyxmxbS/GxV2qtSJgmTK+eLmEbFP2XpF
         Mf8+vSzJmDyM3/JgX9NUeiYQnseYM7TOrWssM4saHYsqD8KT8KBZufm3V+Dl8tZdifyj
         0fnrlfez63XIrbof/+ROfyCSVAJB/HQubxxP86zb7g3RXjN4zuUGxMWotbh38tclrMx8
         9ZXZtTRH0ZwMdYVMoypeTuz8q4YjnvPNKIchfPJeq4tXj3r//JMsGOp7MuYmAoEYtZxf
         ygGKWZbLoJroXWHLvYp3nE/rfiQ/hjiJl9EAAxig1SSz+75kbsXtgHZasZnoier2+WPE
         2ePg==
X-Gm-Message-State: APjAAAW8IyYN9SJmUsTYymoiPL+TPpBPsQZJy8mMpcRDJUZNPnBEk2Xl
        miODXJ5E1EMlR6pPqbrs+O8Q/37sPGuUTE1C66s=
X-Google-Smtp-Source: APXvYqzmV3AzkM/SfCnKTe4AlxAPVe8+t2AApUhv9UuNreHOqtUS/OieHIlfJQtzEFxPo06J+cprzrLBkfbhdMDK/mc=
X-Received: by 2002:aa7:82d6:: with SMTP id f22mr90368730pfn.151.1560370800217;
 Wed, 12 Jun 2019 13:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560364493.git.mchehab+samsung@kernel.org> <7dd6dfc3b0771e1035134fcb8151f4231c078615.1560364494.git.mchehab+samsung@kernel.org>
In-Reply-To: <7dd6dfc3b0771e1035134fcb8151f4231c078615.1560364494.git.mchehab+samsung@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Jun 2019 23:19:47 +0300
Message-ID: <CAHp75VdDWceNMje2hdgD7KiOBw+MeMsfYLKjV+Jjn-PNMy2w3g@mail.gmail.com>
Subject: Re: [PATCH v1 23/31] docs: laptops: convert to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mattia Dongili <malattia@linux.it>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 9:38 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Rename the laptops documentation files to ReST, add an
> index for them and adjust in order to produce a nice html
> output via the Sphinx build system.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>

Thanks!
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-block-device  |   2 +-
>  .../ABI/testing/sysfs-platform-asus-laptop    |   2 +-
>  .../admin-guide/kernel-parameters.txt         |   2 +-
>  .../{asus-laptop.txt =3D> asus-laptop.rst}      |  92 ++--
>  ...otection.txt =3D> disk-shock-protection.rst} |  32 +-
>  Documentation/laptops/index.rst               |  17 +
>  .../{laptop-mode.txt =3D> laptop-mode.rst}      | 509 +++++++++---------
>  .../{sony-laptop.txt =3D> sony-laptop.rst}      |  58 +-
>  .../laptops/{sonypi.txt =3D> sonypi.rst}        |  28 +-
>  .../{thinkpad-acpi.txt =3D> thinkpad-acpi.rst}  | 363 ++++++++-----
>  .../{toshiba_haps.txt =3D> toshiba_haps.rst}    |  47 +-
>  Documentation/sysctl/vm.txt                   |   4 +-
>  MAINTAINERS                                   |   2 +-
>  drivers/char/Kconfig                          |   2 +-
>  drivers/platform/x86/Kconfig                  |   4 +-
>  15 files changed, 660 insertions(+), 504 deletions(-)
>  rename Documentation/laptops/{asus-laptop.txt =3D> asus-laptop.rst} (84%=
)
>  rename Documentation/laptops/{disk-shock-protection.txt =3D> disk-shock-=
protection.rst} (91%)
>  create mode 100644 Documentation/laptops/index.rst
>  rename Documentation/laptops/{laptop-mode.txt =3D> laptop-mode.rst} (62%=
)
>  rename Documentation/laptops/{sony-laptop.txt =3D> sony-laptop.rst} (85%=
)
>  rename Documentation/laptops/{sonypi.txt =3D> sonypi.rst} (87%)
>  rename Documentation/laptops/{thinkpad-acpi.txt =3D> thinkpad-acpi.rst} =
(89%)
>  rename Documentation/laptops/{toshiba_haps.txt =3D> toshiba_haps.rst} (6=
0%)
>
> diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation=
/ABI/testing/sysfs-block-device
> index 82ef6eab042d..0d57bbb4fddc 100644
> --- a/Documentation/ABI/testing/sysfs-block-device
> +++ b/Documentation/ABI/testing/sysfs-block-device
> @@ -45,7 +45,7 @@ Description:
>                 - Values below -2 are rejected with -EINVAL
>
>                 For more information, see
> -               Documentation/laptops/disk-shock-protection.txt
> +               Documentation/laptops/disk-shock-protection.rst
>
>
>  What:          /sys/block/*/device/ncq_prio_enable
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-laptop b/Docum=
entation/ABI/testing/sysfs-platform-asus-laptop
> index cd9d667c3da2..d67fa4bafa70 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-laptop
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-laptop
> @@ -31,7 +31,7 @@ Description:
>                 To control the LED display, use the following :
>                     echo 0x0T000DDD > /sys/devices/platform/asus_laptop/
>                 where T control the 3 letters display, and DDD the 3 digi=
ts display.
> -               The DDD table can be found in Documentation/laptops/asus-=
laptop.txt
> +               The DDD table can be found in Documentation/laptops/asus-=
laptop.rst
>
>  What:          /sys/devices/platform/asus_laptop/bluetooth
>  Date:          January 2007
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 3faf37b8b001..7abe677f8c5e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4356,7 +4356,7 @@
>                         Format: <integer>
>
>         sonypi.*=3D       [HW] Sony Programmable I/O Control Device drive=
r
> -                       See Documentation/laptops/sonypi.txt
> +                       See Documentation/laptops/sonypi.rst
>
>         spectre_v2=3D     [X86] Control mitigation of Spectre variant 2
>                         (indirect branch speculation) vulnerability.
> diff --git a/Documentation/laptops/asus-laptop.txt b/Documentation/laptop=
s/asus-laptop.rst
> similarity index 84%
> rename from Documentation/laptops/asus-laptop.txt
> rename to Documentation/laptops/asus-laptop.rst
> index 5f2858712aa0..95176321a25a 100644
> --- a/Documentation/laptops/asus-laptop.txt
> +++ b/Documentation/laptops/asus-laptop.rst
> @@ -1,6 +1,9 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Asus Laptop Extras
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Version 0.1
> +
>  August 6, 2009
>
>  Corentin Chary <corentincj@iksaif.net>
> @@ -10,11 +13,12 @@ http://acpi4asus.sf.net/
>   It may also support some MEDION, JVC or VICTOR laptops (such as MEDION =
9675 or
>   VICTOR XP7210 for example). It makes all the extra buttons generate inp=
ut
>   events (like keyboards).
> +
>   On some models adds support for changing the display brightness and out=
put,
>   switching the LCD backlight on and off, and most importantly, allows yo=
u to
>   blink those fancy LEDs intended for reporting mail and wireless status.
>
> -This driver supercedes the old asus_acpi driver.
> +This driver supersedes the old asus_acpi driver.
>
>  Requirements
>  ------------
> @@ -49,7 +53,7 @@ Usage
>    see some lines like this :
>
>        Asus Laptop Extras version 0.42
> -        L2D model detected.
> +        - L2D model detected.
>
>    If it is not the output you have on your laptop, send it (and the lapt=
op's
>    DSDT) to me.
> @@ -68,9 +72,12 @@ Usage
>  LEDs
>  ----
>
> -  You can modify LEDs be echoing values to /sys/class/leds/asus::*/brigh=
tness :
> +  You can modify LEDs be echoing values to `/sys/class/leds/asus/*/brigh=
tness`::
> +
>      echo 1 >  /sys/class/leds/asus::mail/brightness
> +
>    will switch the mail LED on.
> +
>    You can also know if they are on/off by reading their content and use
>    kernel triggers like disk-activity or heartbeat.
>
> @@ -81,7 +88,7 @@ Backlight
>    /sys/class/backlight/asus-laptop/. Brightness Values are between 0 and=
 15.
>
>  Wireless devices
> ----------------
> +----------------
>
>    You can turn the internal Bluetooth adapter on/off with the bluetooth =
entry
>    (only on models with Bluetooth). This usually controls the associated =
LED.
> @@ -93,18 +100,20 @@ Display switching
>    Note: the display switching code is currently considered EXPERIMENTAL.
>
>    Switching works for the following models:
> -    L3800C
> -    A2500H
> -    L5800C
> -    M5200N
> -    W1000N (albeit with some glitches)
> -    M6700R
> -    A6JC
> -    F3J
> +
> +    - L3800C
> +    - A2500H
> +    - L5800C
> +    - M5200N
> +    - W1000N (albeit with some glitches)
> +    - M6700R
> +    - A6JC
> +    - F3J
>
>    Switching doesn't work for the following:
> -    M3700N
> -    L2X00D (locks the laptop under certain conditions)
> +
> +    - M3700N
> +    - L2X00D (locks the laptop under certain conditions)
>
>    To switch the displays, echo values from 0 to 15 to
>    /sys/devices/platform/asus-laptop/display. The significance of those v=
alues
> @@ -113,48 +122,51 @@ Display switching
>    +-------+-----+-----+-----+-----+-----+
>    | Bin   | Val | DVI | TV  | CRT | LCD |
>    +-------+-----+-----+-----+-----+-----+
> -  + 0000  +   0 +     +     +     +     +
> +  | 0000  |   0 |     |     |     |     |
>    +-------+-----+-----+-----+-----+-----+
> -  + 0001  +   1 +     +     +     +  X  +
> +  | 0001  |   1 |     |     |     |  X  |
>    +-------+-----+-----+-----+-----+-----+
> -  + 0010  +   2 +     +     +  X  +     +
> +  | 0010  |   2 |     |     |  X  |     |
>    +-------+-----+-----+-----+-----+-----+
> -  + 0011  +   3 +     +     +  X  +  X  +
> +  | 0011  |   3 |     |     |  X  |  X  |
>    +-------+-----+-----+-----+-----+-----+
> -  + 0100  +   4 +     +  X  +     +     +
> +  | 0100  |   4 |     |  X  |     |     |
>    +-------+-----+-----+-----+-----+-----+
> -  + 0101  +   5 +     +  X  +     + X   +
> +  | 0101  |   5 |     |  X  |     | X   |
>    +-------+-----+-----+-----+-----+-----+
> -  + 0110  +   6 +     +  X  +  X  +     +
> +  | 0110  |   6 |     |  X  |  X  |     |
>    +-------+-----+-----+-----+-----+-----+
> -  + 0111  +   7 +     +  X  +  X  +  X  +
> +  | 0111  |   7 |     |  X  |  X  |  X  |
>    +-------+-----+-----+-----+-----+-----+
> -  + 1000  +   8 +  X  +     +     +     +
> +  | 1000  |   8 |  X  |     |     |     |
>    +-------+-----+-----+-----+-----+-----+
> -  + 1001  +   9 +  X  +     +     +  X  +
> +  | 1001  |   9 |  X  |     |     |  X  |
>    +-------+-----+-----+-----+-----+-----+
> -  + 1010  +  10 +  X  +     +  X  +     +
> +  | 1010  |  10 |  X  |     |  X  |     |
>    +-------+-----+-----+-----+-----+-----+
> -  + 1011  +  11 +  X  +     +  X  +  X  +
> +  | 1011  |  11 |  X  |     |  X  |  X  |
>    +-------+-----+-----+-----+-----+-----+
> -  + 1100  +  12 +  X  +  X  +     +     +
> +  | 1100  |  12 |  X  |  X  |     |     |
>    +-------+-----+-----+-----+-----+-----+
> -  + 1101  +  13 +  X  +  X  +     +  X  +
> +  | 1101  |  13 |  X  |  X  |     |  X  |
>    +-------+-----+-----+-----+-----+-----+
> -  + 1110  +  14 +  X  +  X  +  X  +     +
> +  | 1110  |  14 |  X  |  X  |  X  |     |
>    +-------+-----+-----+-----+-----+-----+
> -  + 1111  +  15 +  X  +  X  +  X  +  X  +
> +  | 1111  |  15 |  X  |  X  |  X  |  X  |
>    +-------+-----+-----+-----+-----+-----+
>
>    In most cases, the appropriate displays must be plugged in for the abo=
ve
>    combinations to work. TV-Out may need to be initialized at boot time.
>
>    Debugging:
> +
>    1) Check whether the Fn+F8 key:
> +
>       a) does not lock the laptop (try a boot with noapic / nolapic if it=
 does)
>       b) generates events (0x6n, where n is the value corresponding to th=
e
>          configuration above)
>       c) actually works
> +
>       Record the disp value at every configuration.
>    2) Echo values from 0 to 15 to /sys/devices/platform/asus-laptop/displ=
ay.
>       Record its value, note any change. If nothing changes, try a broade=
r range,
> @@ -164,7 +176,7 @@ Display switching
>
>    Note: on some machines (e.g. L3C), after the module has been loaded, o=
nly 0x6n
>    events are generated and no actual switching occurs. In such a case, a=
 line
> -  like:
> +  like::
>
>      echo $((10#$arg-60)) > /sys/devices/platform/asus-laptop/display
>
> @@ -180,15 +192,16 @@ LED display
>    several items of information.
>
>    LED display works for the following models:
> -    W1000N
> -    W1J
>
> -  To control the LED display, use the following :
> +    - W1000N
> +    - W1J
> +
> +  To control the LED display, use the following::
>
>      echo 0x0T000DDD > /sys/devices/platform/asus-laptop/
>
>    where T control the 3 letters display, and DDD the 3 digits display,
> -  according to the tables below.
> +  according to the tables below::
>
>           DDD (digits)
>           000 to 999 =3D display digits
> @@ -208,8 +221,8 @@ LED display
>    For example "echo 0x01000001 >/sys/devices/platform/asus-laptop/ledd"
>    would display "DVD001".
>
> -Driver options:
> ----------------
> +Driver options
> +--------------
>
>   Options can be passed to the asus-laptop driver using the standard
>   module argument syntax (<param>=3D<value> when passing the option to th=
e
> @@ -219,6 +232,7 @@ Driver options:
>              wapf: WAPF defines the behavior of the Fn+Fx wlan key
>                    The significance of values is yet to be found, but
>                    most of the time:
> +
>                    - 0x0 should do nothing
>                    - 0x1 should allow to control the device with Fn+Fx ke=
y.
>                    - 0x4 should send an ACPI event (0x88) while pressing =
the Fn+Fx key
> @@ -237,7 +251,7 @@ Unsupported models
>   - ASUS L7300G
>   - ASUS L8400
>
> -Patches, Errors, Questions:
> +Patches, Errors, Questions
>  --------------------------
>
>   I appreciate any success or failure
> @@ -253,5 +267,5 @@ Patches, Errors, Questions:
>   Any other comments or patches are also more than welcome.
>
>   acpi4asus-user@lists.sourceforge.net
> +
>   http://sourceforge.net/projects/acpi4asus
> -
> diff --git a/Documentation/laptops/disk-shock-protection.txt b/Documentat=
ion/laptops/disk-shock-protection.rst
> similarity index 91%
> rename from Documentation/laptops/disk-shock-protection.txt
> rename to Documentation/laptops/disk-shock-protection.rst
> index 0e6ba2663834..e97c5f78d8c3 100644
> --- a/Documentation/laptops/disk-shock-protection.txt
> +++ b/Documentation/laptops/disk-shock-protection.rst
> @@ -1,17 +1,18 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  Hard disk shock protection
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
>  Author: Elias Oltmanns <eo@nebensachen.de>
> +
>  Last modified: 2008-10-03
>
>
> -0. Contents
> ------------
> +.. 0. Contents
>
> -1. Intro
> -2. The interface
> -3. References
> -4. CREDITS
> +   1. Intro
> +   2. The interface
> +   3. References
> +   4. CREDITS
>
>
>  1. Intro
> @@ -36,8 +37,8 @@ that).
>  ----------------
>
>  For each ATA device, the kernel exports the file
> -block/*/device/unload_heads in sysfs (here assumed to be mounted under
> -/sys). Access to /sys/block/*/device/unload_heads is denied with
> +`block/*/device/unload_heads` in sysfs (here assumed to be mounted under
> +/sys). Access to `/sys/block/*/device/unload_heads` is denied with
>  -EOPNOTSUPP if the device does not support the unload feature.
>  Otherwise, writing an integer value to this file will take the heads
>  of the respective drive off the platter and block all I/O operations
> @@ -54,18 +55,18 @@ cancel a previously set timeout and resume normal ope=
ration
>  immediately by specifying a timeout of 0. Values below -2 are rejected
>  with -EINVAL (see below for the special meaning of -1 and -2). If the
>  timeout specified for a recent head park request has not yet expired,
> -reading from /sys/block/*/device/unload_heads will report the number
> +reading from `/sys/block/*/device/unload_heads` will report the number
>  of milliseconds remaining until normal operation will be resumed;
>  otherwise, reading the unload_heads attribute will return 0.
>
>  For example, do the following in order to park the heads of drive
> -/dev/sda and stop all I/O operations for five seconds:
> +/dev/sda and stop all I/O operations for five seconds::
>
> -# echo 5000 > /sys/block/sda/device/unload_heads
> +       # echo 5000 > /sys/block/sda/device/unload_heads
>
> -A simple
> +A simple::
>
> -# cat /sys/block/sda/device/unload_heads
> +       # cat /sys/block/sda/device/unload_heads
>
>  will show you how many milliseconds are left before normal operation
>  will be resumed.
> @@ -112,9 +113,9 @@ unload_heads attribute. If you know that your device =
really does
>  support the unload feature (for instance, because the vendor of your
>  laptop or the hard drive itself told you so), then you can tell the
>  kernel to enable the usage of this feature for that drive by writing
> -the special value -1 to the unload_heads attribute:
> +the special value -1 to the unload_heads attribute::
>
> -# echo -1 > /sys/block/sda/device/unload_heads
> +       # echo -1 > /sys/block/sda/device/unload_heads
>
>  will enable the feature for /dev/sda, and giving -2 instead of -1 will
>  disable it again.
> @@ -135,6 +136,7 @@ for use. Please feel free to add projects that have b=
een the victims
>  of my ignorance.
>
>  - http://www.thinkwiki.org/wiki/HDAPS
> +
>    See this page for information about Linux support of the hard disk
>    active protection system as implemented in IBM/Lenovo Thinkpads.
>
> diff --git a/Documentation/laptops/index.rst b/Documentation/laptops/inde=
x.rst
> new file mode 100644
> index 000000000000..001a30910d09
> --- /dev/null
> +++ b/Documentation/laptops/index.rst
> @@ -0,0 +1,17 @@
> +:orphan:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Laptop Drivers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   asus-laptop
> +   disk-shock-protection
> +   laptop-mode
> +   lg-laptop
> +   sony-laptop
> +   sonypi
> +   thinkpad-acpi
> +   toshiba_haps
> diff --git a/Documentation/laptops/laptop-mode.txt b/Documentation/laptop=
s/laptop-mode.rst
> similarity index 62%
> rename from Documentation/laptops/laptop-mode.txt
> rename to Documentation/laptops/laptop-mode.rst
> index 1c707fc9b141..c984c4262f2e 100644
> --- a/Documentation/laptops/laptop-mode.txt
> +++ b/Documentation/laptops/laptop-mode.rst
> @@ -1,8 +1,11 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  How to conserve battery power using laptop-mode
> ------------------------------------------------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Document Author: Bart Samwel (bart@samwel.tk)
> +
>  Date created: January 2, 2004
> +
>  Last modified: December 06, 2004
>
>  Introduction
> @@ -12,17 +15,16 @@ Laptop mode is used to minimize the time that the har=
d disk needs to be spun up,
>  to conserve battery power on laptops. It has been reported to cause sign=
ificant
>  power savings.
>
> -Contents
> ---------
> +.. Contents
>
> -* Introduction
> -* Installation
> -* Caveats
> -* The Details
> -* Tips & Tricks
> -* Control script
> -* ACPI integration
> -* Monitoring tool
> +   * Introduction
> +   * Installation
> +   * Caveats
> +   * The Details
> +   * Tips & Tricks
> +   * Control script
> +   * ACPI integration
> +   * Monitoring tool
>
>
>  Installation
> @@ -33,7 +35,7 @@ or anything. Simply install all the files included in t=
his document, and
>  laptop mode will automatically be started when you're on battery. For
>  your convenience, a tarball containing an installer can be downloaded at=
:
>
> -http://www.samwel.tk/laptop_mode/laptop_mode/
> +       http://www.samwel.tk/laptop_mode/laptop_mode/
>
>  To configure laptop mode, you need to edit the configuration file, which=
 is
>  located in /etc/default/laptop-mode on Debian-based systems, or in
> @@ -209,7 +211,7 @@ Tips & Tricks
>    this on powerbooks too. I hope that this is a piece of information tha=
t
>    might be useful to the Laptop Mode patch or its users."
>
> -* In syslog.conf, you can prefix entries with a dash ``-'' to omit synci=
ng the
> +* In syslog.conf, you can prefix entries with a dash `-` to omit syncing=
 the
>    file after every logging. When you're using laptop-mode and your disk =
doesn't
>    spin down, this is a likely culprit.
>
> @@ -233,83 +235,82 @@ configuration file
>  It should be installed as /etc/default/laptop-mode on Debian, and as
>  /etc/sysconfig/laptop-mode on Red Hat, SUSE, Mandrake, and other work-al=
ikes.
>
> ---------------------CONFIG FILE BEGIN-----------------------------------=
--------
> -# Maximum time, in seconds, of hard drive spindown time that you are
> -# comfortable with. Worst case, it's possible that you could lose this
> -# amount of work if your battery fails you while in laptop mode.
> -#MAX_AGE=3D600
> +Config file::
>
> -# Automatically disable laptop mode when the number of minutes of batter=
y
> -# that you have left goes below this threshold.
> -MINIMUM_BATTERY_MINUTES=3D10
> +  # Maximum time, in seconds, of hard drive spindown time that you are
> +  # comfortable with. Worst case, it's possible that you could lose this
> +  # amount of work if your battery fails you while in laptop mode.
> +  #MAX_AGE=3D600
>
> -# Read-ahead, in 512-byte sectors. You can spin down the disk while play=
ing MP3/OGG
> -# by setting the disk readahead to 8MB (READAHEAD=3D16384). Effectively,=
 the disk
> -# will read a complete MP3 at once, and will then spin down while the MP=
3/OGG is
> -# playing.
> -#READAHEAD=3D4096
> +  # Automatically disable laptop mode when the number of minutes of batt=
ery
> +  # that you have left goes below this threshold.
> +  MINIMUM_BATTERY_MINUTES=3D10
>
> -# Shall we remount journaled fs. with appropriate commit interval? (1=3D=
yes)
> -#DO_REMOUNTS=3D1
> +  # Read-ahead, in 512-byte sectors. You can spin down the disk while pl=
aying MP3/OGG
> +  # by setting the disk readahead to 8MB (READAHEAD=3D16384). Effectivel=
y, the disk
> +  # will read a complete MP3 at once, and will then spin down while the =
MP3/OGG is
> +  # playing.
> +  #READAHEAD=3D4096
>
> -# And shall we add the "noatime" option to that as well? (1=3Dyes)
> -#DO_REMOUNT_NOATIME=3D1
> +  # Shall we remount journaled fs. with appropriate commit interval? (1=
=3Dyes)
> +  #DO_REMOUNTS=3D1
>
> -# Dirty synchronous ratio.  At this percentage of dirty pages the proces=
s
> -# which
> -# calls write() does its own writeback
> -#DIRTY_RATIO=3D40
> +  # And shall we add the "noatime" option to that as well? (1=3Dyes)
> +  #DO_REMOUNT_NOATIME=3D1
>
> -#
> -# Allowed dirty background ratio, in percent.  Once DIRTY_RATIO has been
> -# exceeded, the kernel will wake flusher threads which will then reduce =
the
> -# amount of dirty memory to dirty_background_ratio.  Set this nice and l=
ow,
> -# so once some writeout has commenced, we do a lot of it.
> -#
> -#DIRTY_BACKGROUND_RATIO=3D5
> +  # Dirty synchronous ratio.  At this percentage of dirty pages the proc=
ess
> +  # which
> +  # calls write() does its own writeback
> +  #DIRTY_RATIO=3D40
>
> -# kernel default dirty buffer age
> -#DEF_AGE=3D30
> -#DEF_UPDATE=3D5
> -#DEF_DIRTY_BACKGROUND_RATIO=3D10
> -#DEF_DIRTY_RATIO=3D40
> -#DEF_XFS_AGE_BUFFER=3D15
> -#DEF_XFS_SYNC_INTERVAL=3D30
> -#DEF_XFS_BUFD_INTERVAL=3D1
> +  #
> +  # Allowed dirty background ratio, in percent.  Once DIRTY_RATIO has be=
en
> +  # exceeded, the kernel will wake flusher threads which will then reduc=
e the
> +  # amount of dirty memory to dirty_background_ratio.  Set this nice and=
 low,
> +  # so once some writeout has commenced, we do a lot of it.
> +  #
> +  #DIRTY_BACKGROUND_RATIO=3D5
>
> -# This must be adjusted manually to the value of HZ in the running kerne=
l
> -# on 2.4, until the XFS people change their 2.4 external interfaces to w=
ork in
> -# centisecs. This can be automated, but it's a work in progress that sti=
ll
> -# needs# some fixes. On 2.6 kernels, XFS uses USER_HZ instead of HZ for
> -# external interfaces, and that is currently always set to 100. So you d=
on't
> -# need to change this on 2.6.
> -#XFS_HZ=3D100
> +  # kernel default dirty buffer age
> +  #DEF_AGE=3D30
> +  #DEF_UPDATE=3D5
> +  #DEF_DIRTY_BACKGROUND_RATIO=3D10
> +  #DEF_DIRTY_RATIO=3D40
> +  #DEF_XFS_AGE_BUFFER=3D15
> +  #DEF_XFS_SYNC_INTERVAL=3D30
> +  #DEF_XFS_BUFD_INTERVAL=3D1
>
> -# Should the maximum CPU frequency be adjusted down while on battery?
> -# Requires CPUFreq to be setup.
> -# See Documentation/admin-guide/pm/cpufreq.rst for more info
> -#DO_CPU=3D0
> +  # This must be adjusted manually to the value of HZ in the running ker=
nel
> +  # on 2.4, until the XFS people change their 2.4 external interfaces to=
 work in
> +  # centisecs. This can be automated, but it's a work in progress that s=
till
> +  # needs# some fixes. On 2.6 kernels, XFS uses USER_HZ instead of HZ fo=
r
> +  # external interfaces, and that is currently always set to 100. So you=
 don't
> +  # need to change this on 2.6.
> +  #XFS_HZ=3D100
>
> -# When on battery what is the maximum CPU speed that the system should
> -# use? Legal values are "slowest" for the slowest speed that your
> -# CPU is able to operate at, or a value listed in:
> -# /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> -# Only applicable if DO_CPU=3D1.
> -#CPU_MAXFREQ=3Dslowest
> +  # Should the maximum CPU frequency be adjusted down while on battery?
> +  # Requires CPUFreq to be setup.
> +  # See Documentation/admin-guide/pm/cpufreq.rst for more info
> +  #DO_CPU=3D0
>
> -# Idle timeout for your hard drive (man hdparm for valid values, -S opti=
on)
> -# Default is 2 hours on AC (AC_HD=3D244) and 20 seconds for battery (BAT=
T_HD=3D4).
> -#AC_HD=3D244
> -#BATT_HD=3D4
> +  # When on battery what is the maximum CPU speed that the system should
> +  # use? Legal values are "slowest" for the slowest speed that your
> +  # CPU is able to operate at, or a value listed in:
> +  # /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> +  # Only applicable if DO_CPU=3D1.
> +  #CPU_MAXFREQ=3Dslowest
>
> -# The drives for which to adjust the idle timeout. Separate them by a sp=
ace,
> -# e.g. HD=3D"/dev/hda /dev/hdb".
> -#HD=3D"/dev/hda"
> +  # Idle timeout for your hard drive (man hdparm for valid values, -S op=
tion)
> +  # Default is 2 hours on AC (AC_HD=3D244) and 20 seconds for battery (B=
ATT_HD=3D4).
> +  #AC_HD=3D244
> +  #BATT_HD=3D4
>
> -# Set the spindown timeout on a hard drive?
> -#DO_HD=3D1
> +  # The drives for which to adjust the idle timeout. Separate them by a =
space,
> +  # e.g. HD=3D"/dev/hda /dev/hdb".
> +  #HD=3D"/dev/hda"
>
> ---------------------CONFIG FILE END-------------------------------------=
--------
> +  # Set the spindown timeout on a hard drive?
> +  #DO_HD=3D1
>
>
>  Control script
> @@ -318,125 +319,126 @@ Control script
>  Please note that this control script works for the Linux 2.4 and 2.6 ser=
ies (thanks
>  to Kiko Piris).
>
> ---------------------CONTROL SCRIPT BEGIN--------------------------------=
--------
> -#!/bin/bash
> +Control script::
>
> -# start or stop laptop_mode, best run by a power management daemon when
> -# ac gets connected/disconnected from a laptop
> -#
> -# install as /sbin/laptop_mode
> -#
> -# Contributors to this script:   Kiko Piris
> -#                               Bart Samwel
> -#                               Micha Feigin
> -#                               Andrew Morton
> -#                               Herve Eychenne
> -#                               Dax Kelson
> -#
> -# Original Linux 2.4 version by: Jens Axboe
> +  #!/bin/bash
>
> -########################################################################=
#####
> +  # start or stop laptop_mode, best run by a power management daemon whe=
n
> +  # ac gets connected/disconnected from a laptop
> +  #
> +  # install as /sbin/laptop_mode
> +  #
> +  # Contributors to this script:   Kiko Piris
> +  #                             Bart Samwel
> +  #                             Micha Feigin
> +  #                             Andrew Morton
> +  #                             Herve Eychenne
> +  #                             Dax Kelson
> +  #
> +  # Original Linux 2.4 version by: Jens Axboe
>
> -# Source config
> -if [ -f /etc/default/laptop-mode ] ; then
> +  ######################################################################=
#######
> +
> +  # Source config
> +  if [ -f /etc/default/laptop-mode ] ; then
>         # Debian
>         . /etc/default/laptop-mode
> -elif [ -f /etc/sysconfig/laptop-mode ] ; then
> +  elif [ -f /etc/sysconfig/laptop-mode ] ; then
>         # Others
> -        . /etc/sysconfig/laptop-mode
> -fi
> +          . /etc/sysconfig/laptop-mode
> +  fi
>
> -# Don't raise an error if the config file is incomplete
> -# set defaults instead:
> +  # Don't raise an error if the config file is incomplete
> +  # set defaults instead:
>
> -# Maximum time, in seconds, of hard drive spindown time that you are
> -# comfortable with. Worst case, it's possible that you could lose this
> -# amount of work if your battery fails you while in laptop mode.
> -MAX_AGE=3D${MAX_AGE:-'600'}
> +  # Maximum time, in seconds, of hard drive spindown time that you are
> +  # comfortable with. Worst case, it's possible that you could lose this
> +  # amount of work if your battery fails you while in laptop mode.
> +  MAX_AGE=3D${MAX_AGE:-'600'}
>
> -# Read-ahead, in kilobytes
> -READAHEAD=3D${READAHEAD:-'4096'}
> +  # Read-ahead, in kilobytes
> +  READAHEAD=3D${READAHEAD:-'4096'}
>
> -# Shall we remount journaled fs. with appropriate commit interval? (1=3D=
yes)
> -DO_REMOUNTS=3D${DO_REMOUNTS:-'1'}
> +  # Shall we remount journaled fs. with appropriate commit interval? (1=
=3Dyes)
> +  DO_REMOUNTS=3D${DO_REMOUNTS:-'1'}
>
> -# And shall we add the "noatime" option to that as well? (1=3Dyes)
> -DO_REMOUNT_NOATIME=3D${DO_REMOUNT_NOATIME:-'1'}
> +  # And shall we add the "noatime" option to that as well? (1=3Dyes)
> +  DO_REMOUNT_NOATIME=3D${DO_REMOUNT_NOATIME:-'1'}
>
> -# Shall we adjust the idle timeout on a hard drive?
> -DO_HD=3D${DO_HD:-'1'}
> +  # Shall we adjust the idle timeout on a hard drive?
> +  DO_HD=3D${DO_HD:-'1'}
>
> -# Adjust idle timeout on which hard drive?
> -HD=3D"${HD:-'/dev/hda'}"
> +  # Adjust idle timeout on which hard drive?
> +  HD=3D"${HD:-'/dev/hda'}"
>
> -# spindown time for HD (hdparm -S values)
> -AC_HD=3D${AC_HD:-'244'}
> -BATT_HD=3D${BATT_HD:-'4'}
> +  # spindown time for HD (hdparm -S values)
> +  AC_HD=3D${AC_HD:-'244'}
> +  BATT_HD=3D${BATT_HD:-'4'}
>
> -# Dirty synchronous ratio.  At this percentage of dirty pages the proces=
s which
> -# calls write() does its own writeback
> -DIRTY_RATIO=3D${DIRTY_RATIO:-'40'}
> +  # Dirty synchronous ratio.  At this percentage of dirty pages the proc=
ess which
> +  # calls write() does its own writeback
> +  DIRTY_RATIO=3D${DIRTY_RATIO:-'40'}
>
> -# cpu frequency scaling
> -# See Documentation/admin-guide/pm/cpufreq.rst for more info
> -DO_CPU=3D${CPU_MANAGE:-'0'}
> -CPU_MAXFREQ=3D${CPU_MAXFREQ:-'slowest'}
> +  # cpu frequency scaling
> +  # See Documentation/admin-guide/pm/cpufreq.rst for more info
> +  DO_CPU=3D${CPU_MANAGE:-'0'}
> +  CPU_MAXFREQ=3D${CPU_MAXFREQ:-'slowest'}
>
> -#
> -# Allowed dirty background ratio, in percent.  Once DIRTY_RATIO has been
> -# exceeded, the kernel will wake flusher threads which will then reduce =
the
> -# amount of dirty memory to dirty_background_ratio.  Set this nice and l=
ow,
> -# so once some writeout has commenced, we do a lot of it.
> -#
> -DIRTY_BACKGROUND_RATIO=3D${DIRTY_BACKGROUND_RATIO:-'5'}
> +  #
> +  # Allowed dirty background ratio, in percent.  Once DIRTY_RATIO has be=
en
> +  # exceeded, the kernel will wake flusher threads which will then reduc=
e the
> +  # amount of dirty memory to dirty_background_ratio.  Set this nice and=
 low,
> +  # so once some writeout has commenced, we do a lot of it.
> +  #
> +  DIRTY_BACKGROUND_RATIO=3D${DIRTY_BACKGROUND_RATIO:-'5'}
>
> -# kernel default dirty buffer age
> -DEF_AGE=3D${DEF_AGE:-'30'}
> -DEF_UPDATE=3D${DEF_UPDATE:-'5'}
> -DEF_DIRTY_BACKGROUND_RATIO=3D${DEF_DIRTY_BACKGROUND_RATIO:-'10'}
> -DEF_DIRTY_RATIO=3D${DEF_DIRTY_RATIO:-'40'}
> -DEF_XFS_AGE_BUFFER=3D${DEF_XFS_AGE_BUFFER:-'15'}
> -DEF_XFS_SYNC_INTERVAL=3D${DEF_XFS_SYNC_INTERVAL:-'30'}
> -DEF_XFS_BUFD_INTERVAL=3D${DEF_XFS_BUFD_INTERVAL:-'1'}
> +  # kernel default dirty buffer age
> +  DEF_AGE=3D${DEF_AGE:-'30'}
> +  DEF_UPDATE=3D${DEF_UPDATE:-'5'}
> +  DEF_DIRTY_BACKGROUND_RATIO=3D${DEF_DIRTY_BACKGROUND_RATIO:-'10'}
> +  DEF_DIRTY_RATIO=3D${DEF_DIRTY_RATIO:-'40'}
> +  DEF_XFS_AGE_BUFFER=3D${DEF_XFS_AGE_BUFFER:-'15'}
> +  DEF_XFS_SYNC_INTERVAL=3D${DEF_XFS_SYNC_INTERVAL:-'30'}
> +  DEF_XFS_BUFD_INTERVAL=3D${DEF_XFS_BUFD_INTERVAL:-'1'}
>
> -# This must be adjusted manually to the value of HZ in the running kerne=
l
> -# on 2.4, until the XFS people change their 2.4 external interfaces to w=
ork in
> -# centisecs. This can be automated, but it's a work in progress that sti=
ll needs
> -# some fixes. On 2.6 kernels, XFS uses USER_HZ instead of HZ for externa=
l
> -# interfaces, and that is currently always set to 100. So you don't need=
 to
> -# change this on 2.6.
> -XFS_HZ=3D${XFS_HZ:-'100'}
> +  # This must be adjusted manually to the value of HZ in the running ker=
nel
> +  # on 2.4, until the XFS people change their 2.4 external interfaces to=
 work in
> +  # centisecs. This can be automated, but it's a work in progress that s=
till needs
> +  # some fixes. On 2.6 kernels, XFS uses USER_HZ instead of HZ for exter=
nal
> +  # interfaces, and that is currently always set to 100. So you don't ne=
ed to
> +  # change this on 2.6.
> +  XFS_HZ=3D${XFS_HZ:-'100'}
>
> -########################################################################=
#####
> +  ######################################################################=
#######
>
> -KLEVEL=3D"$(uname -r |
> -             {
> +  KLEVEL=3D"$(uname -r |
> +               {
>                IFS=3D'.' read a b c
>                echo $a.$b
>              }
> -)"
> -case "$KLEVEL" in
> +  )"
> +  case "$KLEVEL" in
>         "2.4"|"2.6")
>                 ;;
>         *)
>                 echo "Unhandled kernel version: $KLEVEL ('uname -r' =3D '=
$(uname -r)')" >&2
>                 exit 1
>                 ;;
> -esac
> +  esac
>
> -if [ ! -e /proc/sys/vm/laptop_mode ] ; then
> +  if [ ! -e /proc/sys/vm/laptop_mode ] ; then
>         echo "Kernel is not patched with laptop_mode patch." >&2
>         exit 1
> -fi
> +  fi
>
> -if [ ! -w /proc/sys/vm/laptop_mode ] ; then
> +  if [ ! -w /proc/sys/vm/laptop_mode ] ; then
>         echo "You do not have enough privileges to enable laptop_mode." >=
&2
>         exit 1
> -fi
> +  fi
>
> -# Remove an option (the first parameter) of the form option=3D<number> f=
rom
> -# a mount options string (the rest of the parameters).
> -parse_mount_opts () {
> +  # Remove an option (the first parameter) of the form option=3D<number>=
 from
> +  # a mount options string (the rest of the parameters).
> +  parse_mount_opts () {
>         OPT=3D"$1"
>         shift
>         echo ",$*," | sed               \
> @@ -444,11 +446,11 @@ parse_mount_opts () {
>          -e 's/,,*/,/g'                 \
>          -e 's/^,//'                    \
>          -e 's/,$//'
> -}
> +  }
>
> -# Remove an option (the first parameter) without any arguments from
> -# a mount option string (the rest of the parameters).
> -parse_nonumber_mount_opts () {
> +  # Remove an option (the first parameter) without any arguments from
> +  # a mount option string (the rest of the parameters).
> +  parse_nonumber_mount_opts () {
>         OPT=3D"$1"
>         shift
>         echo ",$*," | sed               \
> @@ -456,20 +458,20 @@ parse_nonumber_mount_opts () {
>          -e 's/,,*/,/g'                 \
>          -e 's/^,//'                    \
>          -e 's/,$//'
> -}
> +  }
>
> -# Find out the state of a yes/no option (e.g. "atime"/"noatime") in
> -# fstab for a given filesystem, and use this state to replace the
> -# value of the option in another mount options string. The device
> -# is the first argument, the option name the second, and the default
> -# value the third. The remainder is the mount options string.
> -#
> -# Example:
> -# parse_yesno_opts_wfstab /dev/hda1 atime atime defaults,noatime
> -#
> -# If fstab contains, say, "rw" for this filesystem, then the result
> -# will be "defaults,atime".
> -parse_yesno_opts_wfstab () {
> +  # Find out the state of a yes/no option (e.g. "atime"/"noatime") in
> +  # fstab for a given filesystem, and use this state to replace the
> +  # value of the option in another mount options string. The device
> +  # is the first argument, the option name the second, and the default
> +  # value the third. The remainder is the mount options string.
> +  #
> +  # Example:
> +  # parse_yesno_opts_wfstab /dev/hda1 atime atime defaults,noatime
> +  #
> +  # If fstab contains, say, "rw" for this filesystem, then the result
> +  # will be "defaults,atime".
> +  parse_yesno_opts_wfstab () {
>         L_DEV=3D"$1"
>         OPT=3D"$2"
>         DEF_OPT=3D"$3"
> @@ -491,21 +493,21 @@ parse_yesno_opts_wfstab () {
>                 # option not specified in fstab -- choose the default.
>                 echo "$PARSEDOPTS1,$DEF_OPT"
>         fi
> -}
> +  }
>
> -# Find out the state of a numbered option (e.g. "commit=3DNNN") in
> -# fstab for a given filesystem, and use this state to replace the
> -# value of the option in another mount options string. The device
> -# is the first argument, and the option name the second. The
> -# remainder is the mount options string in which the replacement
> -# must be done.
> -#
> -# Example:
> -# parse_mount_opts_wfstab /dev/hda1 commit defaults,commit=3D7
> -#
> -# If fstab contains, say, "commit=3D3,rw" for this filesystem, then the
> -# result will be "rw,commit=3D3".
> -parse_mount_opts_wfstab () {
> +  # Find out the state of a numbered option (e.g. "commit=3DNNN") in
> +  # fstab for a given filesystem, and use this state to replace the
> +  # value of the option in another mount options string. The device
> +  # is the first argument, and the option name the second. The
> +  # remainder is the mount options string in which the replacement
> +  # must be done.
> +  #
> +  # Example:
> +  # parse_mount_opts_wfstab /dev/hda1 commit defaults,commit=3D7
> +  #
> +  # If fstab contains, say, "commit=3D3,rw" for this filesystem, then th=
e
> +  # result will be "rw,commit=3D3".
> +  parse_mount_opts_wfstab () {
>         L_DEV=3D"$1"
>         OPT=3D"$2"
>         shift 2
> @@ -523,9 +525,9 @@ parse_mount_opts_wfstab () {
>                 # option not specified in fstab: set it to 0
>                 echo "$PARSEDOPTS1,$OPT=3D0"
>         fi
> -}
> +  }
>
> -deduce_fstype () {
> +  deduce_fstype () {
>         MP=3D"$1"
>         # My root filesystem unfortunately has
>         # type "unknown" in /etc/mtab. If we encounter
> @@ -538,13 +540,13 @@ deduce_fstype () {
>                         exit 0
>                 fi
>         done
> -}
> +  }
>
> -if [ $DO_REMOUNT_NOATIME -eq 1 ] ; then
> +  if [ $DO_REMOUNT_NOATIME -eq 1 ] ; then
>         NOATIME_OPT=3D",noatime"
> -fi
> +  fi
>
> -case "$1" in
> +  case "$1" in
>         start)
>                 AGE=3D$((100*$MAX_AGE))
>                 XFS_AGE=3D$(($XFS_HZ*$MAX_AGE))
> @@ -687,10 +689,9 @@ case "$1" in
>                 exit 1
>                 ;;
>
> -esac
> +  esac
>
> -exit 0
> ---------------------CONTROL SCRIPT END----------------------------------=
--------
> +  exit 0
>
>
>  ACPI integration
> @@ -701,78 +702,76 @@ kick off the laptop_mode script and run hdparm. The=
 part that
>  automatically disables laptop mode when the battery is low was
>  written by Jan Topinski.
>
> ------------------/etc/acpi/events/ac_adapter BEGIN----------------------=
--------
> -event=3Dac_adapter
> -action=3D/etc/acpi/actions/ac.sh %e
> -----------------/etc/acpi/events/ac_adapter END-------------------------=
--------
> +/etc/acpi/events/ac_adapter::
>
> +       event=3Dac_adapter
> +       action=3D/etc/acpi/actions/ac.sh %e
>
> ------------------/etc/acpi/events/battery BEGIN-------------------------=
--------
> -event=3Dbattery.*
> -action=3D/etc/acpi/actions/battery.sh %e
> -----------------/etc/acpi/events/battery END----------------------------=
--------
> +/etc/acpi/events/battery::
>
> +       event=3Dbattery.*
> +       action=3D/etc/acpi/actions/battery.sh %e
>
> -----------------/etc/acpi/actions/ac.sh BEGIN---------------------------=
--------
> -#!/bin/bash
> +/etc/acpi/actions/ac.sh::
>
> -# ac on/offline event handler
> +  #!/bin/bash
>
> -status=3D`awk '/^state: / { print $2 }' /proc/acpi/ac_adapter/$2/state`
> +  # ac on/offline event handler
>
> -case $status in
> -        "on-line")
> -                /sbin/laptop_mode stop
> -                exit 0
> -        ;;
> -        "off-line")
> -                /sbin/laptop_mode start
> -                exit 0
> -        ;;
> -esac
> ----------------------------/etc/acpi/actions/ac.sh END------------------=
--------
> +  status=3D`awk '/^state: / { print $2 }' /proc/acpi/ac_adapter/$2/state=
`
>
> +  case $status in
> +          "on-line")
> +                  /sbin/laptop_mode stop
> +                  exit 0
> +          ;;
> +          "off-line")
> +                  /sbin/laptop_mode start
> +                  exit 0
> +          ;;
> +  esac
>
> ----------------------------/etc/acpi/actions/battery.sh BEGIN-----------=
--------
> -#! /bin/bash
>
> -# Automatically disable laptop mode when the battery almost runs out.
> +/etc/acpi/actions/battery.sh::
>
> -BATT_INFO=3D/proc/acpi/battery/$2/state
> +  #! /bin/bash
>
> -if [[ -f /proc/sys/vm/laptop_mode ]]
> -then
> -   LM=3D`cat /proc/sys/vm/laptop_mode`
> -   if [[ $LM -gt 0 ]]
> -   then
> -     if [[ -f $BATT_INFO ]]
> +  # Automatically disable laptop mode when the battery almost runs out.
> +
> +  BATT_INFO=3D/proc/acpi/battery/$2/state
> +
> +  if [[ -f /proc/sys/vm/laptop_mode ]]
> +  then
> +     LM=3D`cat /proc/sys/vm/laptop_mode`
> +     if [[ $LM -gt 0 ]]
>       then
> -        # Source the config file only now that we know we need
> -        if [ -f /etc/default/laptop-mode ] ; then
> -                # Debian
> -                . /etc/default/laptop-mode
> -        elif [ -f /etc/sysconfig/laptop-mode ] ; then
> -                # Others
> -                . /etc/sysconfig/laptop-mode
> -        fi
> -        MINIMUM_BATTERY_MINUTES=3D${MINIMUM_BATTERY_MINUTES:-'10'}
> +       if [[ -f $BATT_INFO ]]
> +       then
> +          # Source the config file only now that we know we need
> +          if [ -f /etc/default/laptop-mode ] ; then
> +                  # Debian
> +                  . /etc/default/laptop-mode
> +          elif [ -f /etc/sysconfig/laptop-mode ] ; then
> +                  # Others
> +                  . /etc/sysconfig/laptop-mode
> +          fi
> +          MINIMUM_BATTERY_MINUTES=3D${MINIMUM_BATTERY_MINUTES:-'10'}
>
> -        ACTION=3D"`cat $BATT_INFO | grep charging | cut -c 26-`"
> -        if [[ ACTION -eq "discharging" ]]
> -        then
> -           PRESENT_RATE=3D`cat $BATT_INFO | grep "present rate:" | sed  =
"s/.* \([0-9][0-9]* \).*/\1/" `
> -           REMAINING=3D`cat $BATT_INFO | grep "remaining capacity:" | se=
d  "s/.* \([0-9][0-9]* \).*/\1/" `
> -        fi
> -        if (($REMAINING * 60 / $PRESENT_RATE < $MINIMUM_BATTERY_MINUTES)=
)
> -        then
> -           /sbin/laptop_mode stop
> -        fi
> -     else
> -       logger -p daemon.warning "You are using laptop mode and your batt=
ery interface $BATT_INFO is missing. This may lead to loss of data when the=
 battery runs out. Check kernel ACPI support and /proc/acpi/battery folder,=
 and edit /etc/acpi/battery.sh to set BATT_INFO to the correct path."
> +          ACTION=3D"`cat $BATT_INFO | grep charging | cut -c 26-`"
> +          if [[ ACTION -eq "discharging" ]]
> +          then
> +             PRESENT_RATE=3D`cat $BATT_INFO | grep "present rate:" | sed=
  "s/.* \([0-9][0-9]* \).*/\1/" `
> +             REMAINING=3D`cat $BATT_INFO | grep "remaining capacity:" | =
sed  "s/.* \([0-9][0-9]* \).*/\1/" `
> +          fi
> +          if (($REMAINING * 60 / $PRESENT_RATE < $MINIMUM_BATTERY_MINUTE=
S))
> +          then
> +             /sbin/laptop_mode stop
> +          fi
> +       else
> +         logger -p daemon.warning "You are using laptop mode and your ba=
ttery interface $BATT_INFO is missing. This may lead to loss of data when t=
he battery runs out. Check kernel ACPI support and /proc/acpi/battery folde=
r, and edit /etc/acpi/battery.sh to set BATT_INFO to the correct path."
> +       fi
>       fi
> -   fi
> -fi
> ----------------------------/etc/acpi/actions/battery.sh END-------------=
-------
> +  fi
>
>
>  Monitoring tool
> diff --git a/Documentation/laptops/sony-laptop.txt b/Documentation/laptop=
s/sony-laptop.rst
> similarity index 85%
> rename from Documentation/laptops/sony-laptop.txt
> rename to Documentation/laptops/sony-laptop.rst
> index 978b1e615155..9edcc7f6612f 100644
> --- a/Documentation/laptops/sony-laptop.txt
> +++ b/Documentation/laptops/sony-laptop.rst
> @@ -1,7 +1,9 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Sony Notebook Control Driver (SNC) Readme
> ------------------------------------------
> -       Copyright (C) 2004- 2005 Stelian Pop <stelian@popies.net>
> -       Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +       - Copyright (C) 2004- 2005 Stelian Pop <stelian@popies.net>
> +       - Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
>
>  This mini-driver drives the SNC and SPIC device present in the ACPI BIOS=
 of the
>  Sony Vaio laptops. This driver mixes both devices functions under the sa=
me
> @@ -10,6 +12,7 @@ obsoleted by sony-laptop now.
>
>  Fn keys (hotkeys):
>  ------------------
> +
>  Some models report hotkeys through the SNC or SPIC devices, such events =
are
>  reported both through the ACPI subsystem as acpi events and through the =
INPUT
>  subsystem. See the logs of /proc/bus/input/devices to find out what thos=
e
> @@ -28,11 +31,14 @@ If your laptop model supports it, you will find sysfs=
 files in the
>  /sys/class/backlight/sony/
>  directory. You will be able to query and set the current screen
>  brightness:
> +
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         brightness              get/set screen brightness (an integer
>                                 between 0 and 7)
>         actual_brightness       reading from this file will query the HW
>                                 to get real brightness value
>         max_brightness          the maximum brightness value
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
>  Platform specific:
> @@ -45,6 +51,8 @@ You then read/write integer values from/to those files =
by using
>  standard UNIX tools.
>
>  The files are:
> +
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         brightness_default      screen brightness which will be set
>                                 when the laptop will be rebooted
>         cdpower                 power on/off the internal CD drive
> @@ -53,21 +61,39 @@ The files are:
>                                 (only in debug mode)
>         bluetoothpower          power on/off the internal bluetooth devic=
e
>         fanspeed                get/set the fan speed
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Note that some files may be missing if they are not supported
>  by your particular laptop model.
>
> -Example usage:
> +Example usage::
> +
>         # echo "1" > /sys/devices/platform/sony-laptop/brightness_default
> -sets the lowest screen brightness for the next and later reboots,
> +
> +sets the lowest screen brightness for the next and later reboots
> +
> +::
> +
>         # echo "8" > /sys/devices/platform/sony-laptop/brightness_default
> -sets the highest screen brightness for the next and later reboots,
> +
> +sets the highest screen brightness for the next and later reboots
> +
> +::
> +
>         # cat /sys/devices/platform/sony-laptop/brightness_default
> -retrieves the value.
> +
> +retrieves the value
> +
> +::
>
>         # echo "0" > /sys/devices/platform/sony-laptop/audiopower
> -powers off the sound card,
> +
> +powers off the sound card
> +
> +::
> +
>         # echo "1" > /sys/devices/platform/sony-laptop/audiopower
> +
>  powers on the sound card.
>
>
> @@ -76,7 +102,8 @@ RFkill control:
>  More recent Vaio models expose a consistent set of ACPI methods to
>  control radio frequency emitting devices. If you are a lucky owner of
>  such a laptop you will find the necessary rfkill devices under
> -/sys/class/rfkill. Check those starting with sony-* in
> +/sys/class/rfkill. Check those starting with sony-* in::
> +
>         # grep . /sys/class/rfkill/*/{state,name}
>
>
> @@ -88,26 +115,29 @@ you are not afraid of any side effects doing strange=
 things with
>  your ACPI BIOS could have on your laptop), load the driver and
>  pass the option 'debug=3D1'.
>
> -REPEAT: DON'T DO THIS IF YOU DON'T LIKE RISKY BUSINESS.
> +REPEAT:
> +       **DON'T DO THIS IF YOU DON'T LIKE RISKY BUSINESS.**
>
>  In your kernel logs you will find the list of all ACPI methods
>  the SNC device has on your laptop.
>
>  * For new models you will see a long list of meaningless method names,
> -reading the DSDT table source should reveal that:
> +  reading the DSDT table source should reveal that:
> +
>  (1) the SNC device uses an internal capability lookup table
>  (2) SN00 is used to find values in the lookup table
>  (3) SN06 and SN07 are used to call into the real methods based on
>      offsets you can obtain iterating the table using SN00
>  (4) SN02 used to enable events.
> +
>  Some values in the capability lookup table are more or less known, see
>  the code for all sony_call_snc_handle calls, others are more obscure.
>
>  * For old models you can see the GCDP/GCDP methods used to pwer on/off
> -the CD drive, but there are others and they are usually different from
> -model to model.
> +  the CD drive, but there are others and they are usually different from
> +  model to model.
>
> -I HAVE NO IDEA WHAT THOSE METHODS DO.
> +**I HAVE NO IDEA WHAT THOSE METHODS DO.**
>
>  The sony-laptop driver creates, for some of those methods (the most
>  current ones found on several Vaio models), an entry under
> diff --git a/Documentation/laptops/sonypi.txt b/Documentation/laptops/son=
ypi.rst
> similarity index 87%
> rename from Documentation/laptops/sonypi.txt
> rename to Documentation/laptops/sonypi.rst
> index 606bdb9ce036..2a1975ed7ee4 100644
> --- a/Documentation/laptops/sonypi.txt
> +++ b/Documentation/laptops/sonypi.rst
> @@ -1,11 +1,13 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>  Sony Programmable I/O Control Device Driver Readme
> ---------------------------------------------------
> -       Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
> -       Copyright (C) 2001-2002 Alc=C3=B4ve <www.alcove.com>
> -       Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
> -       Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
> -       Copyright (C) 2000 Takaya Kinjo <t-kinjo@tc4.so-net.ne.jp>
> -       Copyright (C) 2000 Andrew Tridgell <tridge@samba.org>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +       - Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
> +       - Copyright (C) 2001-2002 Alc=C3=B4ve <www.alcove.com>
> +       - Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
> +       - Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
> +       - Copyright (C) 2000 Takaya Kinjo <t-kinjo@tc4.so-net.ne.jp>
> +       - Copyright (C) 2000 Andrew Tridgell <tridge@samba.org>
>
>  This driver enables access to the Sony Programmable I/O Control Device w=
hich
>  can be found in many Sony Vaio laptops. Some newer Sony laptops (seems t=
o be
> @@ -14,6 +16,7 @@ sonypi device and are not supported at all by this driv=
er.
>
>  It will give access (through a user space utility) to some events those =
laptops
>  generate, like:
> +
>         - jogdial events (the small wheel on the side of Vaios)
>         - capture button events (only on Vaio Picturebook series)
>         - Fn keys
> @@ -49,6 +52,7 @@ module argument syntax (<param>=3D<value> when passing =
the option to the
>  module or sonypi.<param>=3D<value> on the kernel boot line when sonypi i=
s
>  statically linked into the kernel). Those options are:
>
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         minor:          minor number of the misc device /dev/sonypi,
>                         default is -1 (automatic allocation, see /proc/mi=
sc
>                         or kernel logs)
> @@ -86,6 +90,8 @@ statically linked into the kernel). Those options are:
>                         will be tried. You can use the following bits to
>                         construct your own event mask (from
>                         drivers/char/sonypi.h):
> +
> +                               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D
>                                 SONYPI_JOGGER_MASK              0x0001
>                                 SONYPI_CAPTURE_MASK             0x0002
>                                 SONYPI_FNKEY_MASK               0x0004
> @@ -100,22 +106,24 @@ statically linked into the kernel). Those options a=
re:
>                                 SONYPI_MEMORYSTICK_MASK         0x0800
>                                 SONYPI_BATTERY_MASK             0x1000
>                                 SONYPI_WIRELESS_MASK            0x2000
> +                               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D
>
>         useinput:       if set (which is the default) two input devices a=
re
>                         created, one which interprets the jogdial events =
as
>                         mouse events, the other one which acts like a
>                         keyboard reporting the pressing of the special ke=
ys.
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Module use:
>  -----------
>
>  In order to automatically load the sonypi module on use, you can put tho=
se
> -lines a configuration file in /etc/modprobe.d/:
> +lines a configuration file in /etc/modprobe.d/::
>
>         alias char-major-10-250 sonypi
>         options sonypi minor=3D250
>
> -This supposes the use of minor 250 for the sonypi device:
> +This supposes the use of minor 250 for the sonypi device::
>
>         # mknod /dev/sonypi c 10 250
>
> @@ -148,5 +156,5 @@ Bugs:
>           http://www.acc.umu.se/~erikw/program/smartdimmer-0.1.tar.bz2
>
>         - since all development was done by reverse engineering, there is
> -         _absolutely no guarantee_ that this driver will not crash your
> +         *absolutely no guarantee* that this driver will not crash your
>           laptop. Permanently.
> diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/lapt=
ops/thinkpad-acpi.rst
> similarity index 89%
> rename from Documentation/laptops/thinkpad-acpi.txt
> rename to Documentation/laptops/thinkpad-acpi.rst
> index 75ef063622d2..19d52fc3c5e9 100644
> --- a/Documentation/laptops/thinkpad-acpi.txt
> +++ b/Documentation/laptops/thinkpad-acpi.rst
> @@ -1,12 +1,15 @@
> -                    ThinkPad ACPI Extras Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +ThinkPad ACPI Extras Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> -                            Version 0.25
> -                        October 16th,  2013
> +Version 0.25
>
> -               Borislav Deianov <borislav@users.sf.net>
> -             Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> -                      http://ibm-acpi.sf.net/
> +October 16th,  2013
>
> +- Borislav Deianov <borislav@users.sf.net>
> +- Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> +
> +http://ibm-acpi.sf.net/
>
>  This is a Linux driver for the IBM and Lenovo ThinkPad laptops. It
>  supports various features of these laptops which are accessible
> @@ -91,7 +94,8 @@ yet ready or stabilized, it is expected that this inter=
face will change,
>  and any and all userspace programs must deal with it.
>
>
> -Notes about the sysfs interface:
> +Notes about the sysfs interface
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>  Unlike what was done with the procfs interface, correctness when talking
>  to the sysfs interfaces will be enforced, as will correctness in the
> @@ -129,6 +133,7 @@ Driver version
>  --------------
>
>  procfs: /proc/acpi/ibm/driver
> +
>  sysfs driver attribute: version
>
>  The driver name and version. No commands can be written to this file.
> @@ -141,9 +146,13 @@ sysfs driver attribute: interface_version
>
>  Version of the thinkpad-acpi sysfs interface, as an unsigned long
>  (output in hex format: 0xAAAABBCC), where:
> -       AAAA - major revision
> -       BB - minor revision
> -       CC - bugfix revision
> +
> +       AAAA
> +         - major revision
> +       BB
> +         - minor revision
> +       CC
> +         - bugfix revision
>
>  The sysfs interface version changelog for the driver can be found at the
>  end of this document.  Changes to the sysfs interface done by the kernel
> @@ -170,6 +179,7 @@ Hot keys
>  --------
>
>  procfs: /proc/acpi/ibm/hotkey
> +
>  sysfs device attribute: hotkey_*
>
>  In a ThinkPad, the ACPI HKEY handler is responsible for communicating
> @@ -181,7 +191,7 @@ firmware will behave in many situations.
>  The driver enables the HKEY ("hot key") event reporting automatically
>  when loaded, and disables it when it is removed.
>
> -The driver will report HKEY events in the following format:
> +The driver will report HKEY events in the following format::
>
>         ibm/hotkey HKEY 00000080 0000xxxx
>
> @@ -217,9 +227,10 @@ ThinkPads, it is still possible to support some extr=
a hotkeys by
>  polling the "CMOS NVRAM" at least 10 times per second.  The driver
>  attempts to enables this functionality automatically when required.
>
> -procfs notes:
> +procfs notes
> +^^^^^^^^^^^^
>
> -The following commands can be written to the /proc/acpi/ibm/hotkey file:
> +The following commands can be written to the /proc/acpi/ibm/hotkey file:=
:
>
>         echo 0xffffffff > /proc/acpi/ibm/hotkey -- enable all hot keys
>         echo 0 > /proc/acpi/ibm/hotkey -- disable all possible hot keys
> @@ -227,7 +238,7 @@ The following commands can be written to the /proc/ac=
pi/ibm/hotkey file:
>         echo reset > /proc/acpi/ibm/hotkey -- restore the recommended mas=
k
>
>  The following commands have been deprecated and will cause the kernel
> -to log a warning:
> +to log a warning::
>
>         echo enable > /proc/acpi/ibm/hotkey -- does nothing
>         echo disable > /proc/acpi/ibm/hotkey -- returns an error
> @@ -237,7 +248,8 @@ maintain maximum bug-to-bug compatibility, it does no=
t report any masks,
>  nor does it allow one to manipulate the hot key mask when the firmware
>  does not support masks at all, even if NVRAM polling is in use.
>
> -sysfs notes:
> +sysfs notes
> +^^^^^^^^^^^
>
>         hotkey_bios_enabled:
>                 DEPRECATED, WILL BE REMOVED SOON.
> @@ -349,7 +361,8 @@ sysfs notes:
>
>                 This attribute has poll()/select() support.
>
> -input layer notes:
> +input layer notes
> +^^^^^^^^^^^^^^^^^
>
>  A Hot key is mapped to a single input layer EV_KEY event, possibly
>  followed by an EV_MSC MSC_SCAN event that shall contain that key's scan
> @@ -362,11 +375,13 @@ remapping KEY_UNKNOWN keys.
>
>  The events are available in an input device, with the following id:
>
> -       Bus:            BUS_HOST
> -       vendor:         0x1014 (PCI_VENDOR_ID_IBM)  or
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +       Bus             BUS_HOST
> +       vendor          0x1014 (PCI_VENDOR_ID_IBM)  or
>                         0x17aa (PCI_VENDOR_ID_LENOVO)
> -       product:        0x5054 ("TP")
> -       version:        0x4101
> +       product         0x5054 ("TP")
> +       version         0x4101
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  The version will have its LSB incremented if the keymap changes in a
>  backwards-compatible way.  The MSB shall always be 0x41 for this input
> @@ -380,9 +395,10 @@ backwards-compatible change for this input device.
>
>  Thinkpad-acpi Hot Key event map (version 0x4101):
>
> +=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>  ACPI   Scan
>  event  code    Key             Notes
> -
> +=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>  0x1001 0x00    FN+F1           -
>
>  0x1002 0x01    FN+F2           IBM: battery (rare)
> @@ -426,7 +442,9 @@ event       code    Key             Notes
>                                 or toggle screen expand
>
>  0x1009 0x08    FN+F9           -
> -       ..      ..              ..
> +
> +...    ...     ...             ...
> +
>  0x100B 0x0A    FN+F11          -
>
>  0x100C 0x0B    FN+F12          Sleep to disk.  You are always
> @@ -480,8 +498,11 @@ event      code    Key             Notes
>  0x1018 0x17    THINKPAD        ThinkPad/Access IBM/Lenovo key
>
>  0x1019 0x18    unknown
> -..     ..      ..
> +
> +...    ...     ...
> +
>  0x1020 0x1F    unknown
> +=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>  The ThinkPad firmware does not allow one to differentiate when most hot
>  keys are pressed or released (either that, or we don't know how to, yet)=
.
> @@ -499,14 +520,17 @@ generate input device EV_KEY events.
>  In addition to the EV_KEY events, thinkpad-acpi may also issue EV_SW
>  events for switches:
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  SW_RFKILL_ALL  T60 and later hardware rfkill rocker switch
>  SW_TABLET_MODE Tablet ThinkPads HKEY events 0x5009 and 0x500A
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -Non hotkey ACPI HKEY event map:
> --------------------------------
> +Non hotkey ACPI HKEY event map
> +------------------------------
>
>  Events that are never propagated by the driver:
>
> +=3D=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  0x2304         System is waking up from suspend to undock
>  0x2305         System is waking up from suspend to eject bay
>  0x2404         System is waking up from hibernation to undock
> @@ -519,10 +543,12 @@ Events that are never propagated by the driver:
>  0x6000         KEYBOARD: Numlock key pressed
>  0x6005         KEYBOARD: Fn key pressed (TO BE VERIFIED)
>  0x7000         Radio Switch may have changed state
> +=3D=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
>  Events that are propagated by the driver to userspace:
>
> +=3D=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  0x2313         ALARM: System is waking up from suspend because
>                 the battery is nearly empty
>  0x2413         ALARM: System is waking up from hibernation because
> @@ -544,6 +570,7 @@ Events that are propagated by the driver to userspace=
:
>  0x6040         Nvidia Optimus/AC adapter related (TO BE VERIFIED)
>  0x60C0         X1 Yoga 2016, Tablet mode status changed
>  0x60F0         Thermal Transformation changed (GMTS, Windows)
> +=3D=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Battery nearly empty alarms are a last resort attempt to get the
>  operating system to hibernate or shutdown cleanly (0x2313), or shutdown
> @@ -562,7 +589,8 @@ cycle, or a system shutdown.  Obviously, something is=
 very wrong if this
>  happens.
>
>
> -Brightness hotkey notes:
> +Brightness hotkey notes
> +^^^^^^^^^^^^^^^^^^^^^^^
>
>  Don't mess with the brightness hotkeys in a Thinkpad.  If you want
>  notifications for OSD, use the sysfs backlight class event support.
> @@ -579,7 +607,9 @@ Bluetooth
>  ---------
>
>  procfs: /proc/acpi/ibm/bluetooth
> +
>  sysfs device attribute: bluetooth_enable (deprecated)
> +
>  sysfs rfkill class: switch "tpacpi_bluetooth_sw"
>
>  This feature shows the presence and current state of a ThinkPad
> @@ -588,22 +618,25 @@ Bluetooth device in the internal ThinkPad CDC slot.
>  If the ThinkPad supports it, the Bluetooth state is stored in NVRAM,
>  so it is kept across reboots and power-off.
>
> -Procfs notes:
> +Procfs notes
> +^^^^^^^^^^^^
>
> -If Bluetooth is installed, the following commands can be used:
> +If Bluetooth is installed, the following commands can be used::
>
>         echo enable > /proc/acpi/ibm/bluetooth
>         echo disable > /proc/acpi/ibm/bluetooth
>
> -Sysfs notes:
> +Sysfs notes
> +^^^^^^^^^^^
>
>         If the Bluetooth CDC card is installed, it can be enabled /
>         disabled through the "bluetooth_enable" thinkpad-acpi device
>         attribute, and its current status can also be queried.
>
>         enable:
> -               0: disables Bluetooth / Bluetooth is disabled
> -               1: enables Bluetooth / Bluetooth is enabled.
> +
> +               - 0: disables Bluetooth / Bluetooth is disabled
> +               - 1: enables Bluetooth / Bluetooth is enabled.
>
>         Note: this interface has been superseded by the generic rfkill
>         class.  It has been deprecated, and it will be removed in year
> @@ -617,7 +650,7 @@ Video output control -- /proc/acpi/ibm/video
>  --------------------------------------------
>
>  This feature allows control over the devices used for video output -
> -LCD, CRT or DVI (if available). The following commands are available:
> +LCD, CRT or DVI (if available). The following commands are available::
>
>         echo lcd_enable > /proc/acpi/ibm/video
>         echo lcd_disable > /proc/acpi/ibm/video
> @@ -630,9 +663,10 @@ LCD, CRT or DVI (if available). The following comman=
ds are available:
>         echo expand_toggle > /proc/acpi/ibm/video
>         echo video_switch > /proc/acpi/ibm/video
>
> -NOTE: Access to this feature is restricted to processes owning the
> -CAP_SYS_ADMIN capability for safety reasons, as it can interact badly
> -enough with some versions of X.org to crash it.
> +NOTE:
> +  Access to this feature is restricted to processes owning the
> +  CAP_SYS_ADMIN capability for safety reasons, as it can interact badly
> +  enough with some versions of X.org to crash it.
>
>  Each video output device can be enabled or disabled individually.
>  Reading /proc/acpi/ibm/video shows the status of each device.
> @@ -665,18 +699,21 @@ ThinkLight control
>  ------------------
>
>  procfs: /proc/acpi/ibm/light
> +
>  sysfs attributes: as per LED class, for the "tpacpi::thinklight" LED
>
> -procfs notes:
> +procfs notes
> +^^^^^^^^^^^^
>
>  The ThinkLight status can be read and set through the procfs interface. =
 A
>  few models which do not make the status available will show the ThinkLig=
ht
> -status as "unknown". The available commands are:
> +status as "unknown". The available commands are::
>
>         echo on  > /proc/acpi/ibm/light
>         echo off > /proc/acpi/ibm/light
>
> -sysfs notes:
> +sysfs notes
> +^^^^^^^^^^^
>
>  The ThinkLight sysfs interface is documented by the LED class
>  documentation, in Documentation/leds/leds-class.rst.  The ThinkLight LED=
 name
> @@ -691,6 +728,7 @@ CMOS/UCMS control
>  -----------------
>
>  procfs: /proc/acpi/ibm/cmos
> +
>  sysfs device attribute: cmos_command
>
>  This feature is mostly used internally by the ACPI firmware to keep the =
legacy
> @@ -707,16 +745,16 @@ The range of valid cmos command numbers is 0 to 21,=
 but not all have an
>  effect and the behavior varies from model to model.  Here is the behavio=
r
>  on the X40 (tpb is the ThinkPad Buttons utility):
>
> -       0 - Related to "Volume down" key press
> -       1 - Related to "Volume up" key press
> -       2 - Related to "Mute on" key press
> -       3 - Related to "Access IBM" key press
> -       4 - Related to "LCD brightness up" key press
> -       5 - Related to "LCD brightness down" key press
> -       11 - Related to "toggle screen expansion" key press/function
> -       12 - Related to "ThinkLight on"
> -       13 - Related to "ThinkLight off"
> -       14 - Related to "ThinkLight" key press (toggle ThinkLight)
> +       - 0 - Related to "Volume down" key press
> +       - 1 - Related to "Volume up" key press
> +       - 2 - Related to "Mute on" key press
> +       - 3 - Related to "Access IBM" key press
> +       - 4 - Related to "LCD brightness up" key press
> +       - 5 - Related to "LCD brightness down" key press
> +       - 11 - Related to "toggle screen expansion" key press/function
> +       - 12 - Related to "ThinkLight on"
> +       - 13 - Related to "ThinkLight off"
> +       - 14 - Related to "ThinkLight" key press (toggle ThinkLight)
>
>  The cmos command interface is prone to firmware split-brain problems, as
>  in newer ThinkPads it is just a compatibility layer.  Do not use it, it =
is
> @@ -748,9 +786,10 @@ are aware of the consequences are welcome to enablin=
g it.
>  Audio mute and microphone mute LEDs are supported, but currently not
>  visible to userspace. They are used by the snd-hda-intel audio driver.
>
> -procfs notes:
> +procfs notes
> +^^^^^^^^^^^^
>
> -The available commands are:
> +The available commands are::
>
>         echo '<LED number> on' >/proc/acpi/ibm/led
>         echo '<LED number> off' >/proc/acpi/ibm/led
> @@ -760,23 +799,24 @@ The <LED number> range is 0 to 15. The set of LEDs =
that can be
>  controlled varies from model to model. Here is the common ThinkPad
>  mapping:
>
> -       0 - power
> -       1 - battery (orange)
> -       2 - battery (green)
> -       3 - UltraBase/dock
> -       4 - UltraBay
> -       5 - UltraBase battery slot
> -       6 - (unknown)
> -       7 - standby
> -       8 - dock status 1
> -       9 - dock status 2
> -       10, 11 - (unknown)
> -       12 - thinkvantage
> -       13, 14, 15 - (unknown)
> +       - 0 - power
> +       - 1 - battery (orange)
> +       - 2 - battery (green)
> +       - 3 - UltraBase/dock
> +       - 4 - UltraBay
> +       - 5 - UltraBase battery slot
> +       - 6 - (unknown)
> +       - 7 - standby
> +       - 8 - dock status 1
> +       - 9 - dock status 2
> +       - 10, 11 - (unknown)
> +       - 12 - thinkvantage
> +       - 13, 14, 15 - (unknown)
>
>  All of the above can be turned on and off and can be made to blink.
>
> -sysfs notes:
> +sysfs notes
> +^^^^^^^^^^^
>
>  The ThinkPad LED sysfs interface is described in detail by the LED class
>  documentation, in Documentation/leds/leds-class.rst.
> @@ -815,7 +855,7 @@ The BEEP method is used internally by the ACPI firmwa=
re to provide
>  audible alerts in various situations. This feature allows the same
>  sounds to be triggered manually.
>
> -The commands are non-negative integer numbers:
> +The commands are non-negative integer numbers::
>
>         echo <number> >/proc/acpi/ibm/beep
>
> @@ -823,25 +863,26 @@ The valid <number> range is 0 to 17. Not all number=
s trigger sounds
>  and the sounds vary from model to model. Here is the behavior on the
>  X40:
>
> -       0 - stop a sound in progress (but use 17 to stop 16)
> -       2 - two beeps, pause, third beep ("low battery")
> -       3 - single beep
> -       4 - high, followed by low-pitched beep ("unable")
> -       5 - single beep
> -       6 - very high, followed by high-pitched beep ("AC/DC")
> -       7 - high-pitched beep
> -       9 - three short beeps
> -       10 - very long beep
> -       12 - low-pitched beep
> -       15 - three high-pitched beeps repeating constantly, stop with 0
> -       16 - one medium-pitched beep repeating constantly, stop with 17
> -       17 - stop 16
> +       - 0 - stop a sound in progress (but use 17 to stop 16)
> +       - 2 - two beeps, pause, third beep ("low battery")
> +       - 3 - single beep
> +       - 4 - high, followed by low-pitched beep ("unable")
> +       - 5 - single beep
> +       - 6 - very high, followed by high-pitched beep ("AC/DC")
> +       - 7 - high-pitched beep
> +       - 9 - three short beeps
> +       - 10 - very long beep
> +       - 12 - low-pitched beep
> +       - 15 - three high-pitched beeps repeating constantly, stop with 0
> +       - 16 - one medium-pitched beep repeating constantly, stop with 17
> +       - 17 - stop 16
>
>
>  Temperature sensors
>  -------------------
>
>  procfs: /proc/acpi/ibm/thermal
> +
>  sysfs device attributes: (hwmon "thinkpad") temp*_input
>
>  Most ThinkPads include six or more separate temperature sensors but only
> @@ -850,10 +891,14 @@ feature shows readings from up to eight different s=
ensors on older
>  ThinkPads, and up to sixteen different sensors on newer ThinkPads.
>
>  For example, on the X40, a typical output may be:
> -temperatures:   42 42 45 41 36 -128 33 -128
> +
> +temperatures:
> +       42 42 45 41 36 -128 33 -128
>
>  On the T43/p, a typical output may be:
> -temperatures:   48 48 36 52 38 -128 31 -128 48 52 48 -128 -128 -128 -128=
 -128
> +
> +temperatures:
> +       48 48 36 52 38 -128 31 -128 48 52 48 -128 -128 -128 -128 -128
>
>  The mapping of thermal sensors to physical locations varies depending on
>  system-board model (and thus, on ThinkPad model).
> @@ -863,46 +908,53 @@ tries to track down these locations for various mod=
els.
>
>  Most (newer?) models seem to follow this pattern:
>
> -1:  CPU
> -2:  (depends on model)
> -3:  (depends on model)
> -4:  GPU
> -5:  Main battery: main sensor
> -6:  Bay battery: main sensor
> -7:  Main battery: secondary sensor
> -8:  Bay battery: secondary sensor
> -9-15: (depends on model)
> +- 1:  CPU
> +- 2:  (depends on model)
> +- 3:  (depends on model)
> +- 4:  GPU
> +- 5:  Main battery: main sensor
> +- 6:  Bay battery: main sensor
> +- 7:  Main battery: secondary sensor
> +- 8:  Bay battery: secondary sensor
> +- 9-15: (depends on model)
>
>  For the R51 (source: Thomas Gruber):
> -2:  Mini-PCI
> -3:  Internal HDD
> +
> +- 2:  Mini-PCI
> +- 3:  Internal HDD
>
>  For the T43, T43/p (source: Shmidoax/Thinkwiki.org)
>  http://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_T43.2C_T43p
> -2:  System board, left side (near PCMCIA slot), reported as HDAPS temp
> -3:  PCMCIA slot
> -9:  MCH (northbridge) to DRAM Bus
> -10: Clock-generator, mini-pci card and ICH (southbridge), under Mini-PCI
> -    card, under touchpad
> -11: Power regulator, underside of system board, below F2 key
> +
> +- 2:  System board, left side (near PCMCIA slot), reported as HDAPS temp
> +- 3:  PCMCIA slot
> +- 9:  MCH (northbridge) to DRAM Bus
> +- 10: Clock-generator, mini-pci card and ICH (southbridge), under Mini-P=
CI
> +      card, under touchpad
> +- 11: Power regulator, underside of system board, below F2 key
>
>  The A31 has a very atypical layout for the thermal sensors
>  (source: Milos Popovic, http://thinkwiki.org/wiki/Thermal_Sensors#ThinkP=
ad_A31)
> -1:  CPU
> -2:  Main Battery: main sensor
> -3:  Power Converter
> -4:  Bay Battery: main sensor
> -5:  MCH (northbridge)
> -6:  PCMCIA/ambient
> -7:  Main Battery: secondary sensor
> -8:  Bay Battery: secondary sensor
>
> +- 1:  CPU
> +- 2:  Main Battery: main sensor
> +- 3:  Power Converter
> +- 4:  Bay Battery: main sensor
> +- 5:  MCH (northbridge)
> +- 6:  PCMCIA/ambient
> +- 7:  Main Battery: secondary sensor
> +- 8:  Bay Battery: secondary sensor
> +
> +
> +Procfs notes
> +^^^^^^^^^^^^
>
> -Procfs notes:
>         Readings from sensors that are not available return -128.
>         No commands can be written to this file.
>
> -Sysfs notes:
> +Sysfs notes
> +^^^^^^^^^^^
> +
>         Sensors that are not available return the ENXIO error.  This
>         status may change at runtime, as there are hotplug thermal
>         sensors, like those inside the batteries and docks.
> @@ -921,6 +973,7 @@ ftp://ftp.suse.com/pub/people/trenn/sources/ec
>
>  Use it to determine the register holding the fan
>  speed on some models. To do that, do the following:
> +
>         - make sure the battery is fully charged
>         - make sure the fan is running
>         - use above mentioned tool to read out the EC
> @@ -941,6 +994,7 @@ LCD brightness control
>  ----------------------
>
>  procfs: /proc/acpi/ibm/brightness
> +
>  sysfs backlight device "thinkpad_screen"
>
>  This feature allows software control of the LCD brightness on ThinkPad
> @@ -985,15 +1039,17 @@ brightness_enable=3D0 forces it to be disabled.  b=
rightness_enable=3D1
>  forces it to be enabled when available, even if the standard ACPI
>  interface is also available.
>
> -Procfs notes:
> +Procfs notes
> +^^^^^^^^^^^^
>
> -       The available commands are:
> +The available commands are::
>
>         echo up   >/proc/acpi/ibm/brightness
>         echo down >/proc/acpi/ibm/brightness
>         echo 'level <level>' >/proc/acpi/ibm/brightness
>
> -Sysfs notes:
> +Sysfs notes
> +^^^^^^^^^^^
>
>  The interface is implemented through the backlight sysfs class, which is
>  poorly documented at this time.
> @@ -1038,6 +1094,7 @@ Volume control (Console Audio control)
>  --------------------------------------
>
>  procfs: /proc/acpi/ibm/volume
> +
>  ALSA: "ThinkPad Console Audio Control", default ID: "ThinkPadEC"
>
>  NOTE: by default, the volume control interface operates in read-only
> @@ -1053,7 +1110,8 @@ Software volume control should be done only in the =
main AC97/HDA
>  mixer.
>
>
> -About the ThinkPad Console Audio control:
> +About the ThinkPad Console Audio control
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>  ThinkPads have a built-in amplifier and muting circuit that drives the
>  console headphone and speakers.  This circuit is after the main AC97
> @@ -1092,13 +1150,14 @@ normal key presses to the operating system (think=
pad-acpi is not
>  involved).
>
>
> -The ThinkPad-ACPI volume control:
> +The ThinkPad-ACPI volume control
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>  The preferred way to interact with the Console Audio control is the
>  ALSA interface.
>
>  The legacy procfs interface allows one to read the current state,
> -and if volume control is enabled, accepts the following commands:
> +and if volume control is enabled, accepts the following commands::
>
>         echo up   >/proc/acpi/ibm/volume
>         echo down >/proc/acpi/ibm/volume
> @@ -1137,13 +1196,15 @@ Fan control and monitoring: fan speed, fan enable=
/disable
>  ---------------------------------------------------------
>
>  procfs: /proc/acpi/ibm/fan
> -sysfs device attributes: (hwmon "thinkpad") fan1_input, pwm1,
> -                         pwm1_enable, fan2_input
> +
> +sysfs device attributes: (hwmon "thinkpad") fan1_input, pwm1, pwm1_enabl=
e, fan2_input
> +
>  sysfs hwmon driver attributes: fan_watchdog
>
> -NOTE NOTE NOTE: fan control operations are disabled by default for
> -safety reasons.  To enable them, the module parameter "fan_control=3D1"
> -must be given to thinkpad-acpi.
> +NOTE NOTE NOTE:
> +   fan control operations are disabled by default for
> +   safety reasons.  To enable them, the module parameter "fan_control=3D=
1"
> +   must be given to thinkpad-acpi.
>
>  This feature attempts to show the current fan speed, control mode and
>  other fan data that might be available.  The speed is read directly
> @@ -1154,7 +1215,8 @@ value on other models.
>  Some Lenovo ThinkPads support a secondary fan.  This fan cannot be
>  controlled separately, it shares the main fan control.
>
> -Fan levels:
> +Fan levels
> +^^^^^^^^^^
>
>  Most ThinkPad fans work in "levels" at the firmware interface.  Level 0
>  stops the fan.  The higher the level, the higher the fan speed, although
> @@ -1209,9 +1271,10 @@ therefore, not suitable to protect against fan mod=
e changes made through
>  means other than the "enable", "disable", and "level" procfs fan
>  commands, or the hwmon fan control sysfs interface.
>
> -Procfs notes:
> +Procfs notes
> +^^^^^^^^^^^^
>
> -The fan may be enabled or disabled with the following commands:
> +The fan may be enabled or disabled with the following commands::
>
>         echo enable  >/proc/acpi/ibm/fan
>         echo disable >/proc/acpi/ibm/fan
> @@ -1219,7 +1282,7 @@ The fan may be enabled or disabled with the followi=
ng commands:
>  Placing a fan on level 0 is the same as disabling it.  Enabling a fan
>  will try to place it in a safe level if it is too slow or disabled.
>
> -The fan level can be controlled with the command:
> +The fan level can be controlled with the command::
>
>         echo 'level <level>' > /proc/acpi/ibm/fan
>
> @@ -1231,7 +1294,7 @@ compatibility.
>
>  On the X31 and X40 (and ONLY on those models), the fan speed can be
>  controlled to a certain degree.  Once the fan is running, it can be
> -forced to run faster or slower with the following command:
> +forced to run faster or slower with the following command::
>
>         echo 'speed <speed>' > /proc/acpi/ibm/fan
>
> @@ -1241,13 +1304,14 @@ effect or the fan speed eventually settles somewh=
ere in that range.  The
>  fan cannot be stopped or started with this command.  This functionality
>  is incomplete, and not available through the sysfs interface.
>
> -To program the safety watchdog, use the "watchdog" command.
> +To program the safety watchdog, use the "watchdog" command::
>
>         echo 'watchdog <interval in seconds>' > /proc/acpi/ibm/fan
>
>  If you want to disable the watchdog, use 0 as the interval.
>
> -Sysfs notes:
> +Sysfs notes
> +^^^^^^^^^^^
>
>  The sysfs interface follows the hwmon subsystem guidelines for the most
>  part, and the exception is the fan safety watchdog.
> @@ -1261,10 +1325,10 @@ to the firmware).
>  Features not yet implemented by the driver return ENOSYS.
>
>  hwmon device attribute pwm1_enable:
> -       0: PWM offline (fan is set to full-speed mode)
> -       1: Manual PWM control (use pwm1 to set fan level)
> -       2: Hardware PWM control (EC "auto" mode)
> -       3: reserved (Software PWM control, not implemented yet)
> +       - 0: PWM offline (fan is set to full-speed mode)
> +       - 1: Manual PWM control (use pwm1 to set fan level)
> +       - 2: Hardware PWM control (EC "auto" mode)
> +       - 3: reserved (Software PWM control, not implemented yet)
>
>         Modes 0 and 2 are not supported by all ThinkPads, and the
>         driver is not always able to detect this.  If it does know a
> @@ -1304,7 +1368,9 @@ WAN
>  ---
>
>  procfs: /proc/acpi/ibm/wan
> +
>  sysfs device attribute: wwan_enable (deprecated)
> +
>  sysfs rfkill class: switch "tpacpi_wwan_sw"
>
>  This feature shows the presence and current state of the built-in
> @@ -1316,22 +1382,24 @@ so it is kept across reboots and power-off.
>  It was tested on a Lenovo ThinkPad X60. It should probably work on other
>  ThinkPad models which come with this module installed.
>
> -Procfs notes:
> +Procfs notes
> +^^^^^^^^^^^^
>
> -If the W-WAN card is installed, the following commands can be used:
> +If the W-WAN card is installed, the following commands can be used::
>
>         echo enable > /proc/acpi/ibm/wan
>         echo disable > /proc/acpi/ibm/wan
>
> -Sysfs notes:
> +Sysfs notes
> +^^^^^^^^^^^
>
>         If the W-WAN card is installed, it can be enabled /
>         disabled through the "wwan_enable" thinkpad-acpi device
>         attribute, and its current status can also be queried.
>
>         enable:
> -               0: disables WWAN card / WWAN card is disabled
> -               1: enables WWAN card / WWAN card is enabled.
> +               - 0: disables WWAN card / WWAN card is disabled
> +               - 1: enables WWAN card / WWAN card is enabled.
>
>         Note: this interface has been superseded by the generic rfkill
>         class.  It has been deprecated, and it will be removed in year
> @@ -1354,7 +1422,8 @@ sysfs rfkill class: switch "tpacpi_uwb_sw"
>  This feature exports an rfkill controller for the UWB device, if one is
>  present and enabled in the BIOS.
>
> -Sysfs notes:
> +Sysfs notes
> +^^^^^^^^^^^
>
>         rfkill controller switch "tpacpi_uwb_sw": refer to
>         Documentation/rfkill.txt for details.
> @@ -1368,11 +1437,11 @@ This sysfs attribute controls the keyboard "face"=
 that will be shown on the
>  Lenovo X1 Carbon 2nd gen (2014)'s adaptive keyboard. The value can be re=
ad
>  and set.
>
> -1 =3D Home mode
> -2 =3D Web-browser mode
> -3 =3D Web-conference mode
> -4 =3D Function mode
> -5 =3D Layflat mode
> +- 1 =3D Home mode
> +- 2 =3D Web-browser mode
> +- 3 =3D Web-conference mode
> +- 4 =3D Function mode
> +- 5 =3D Layflat mode
>
>  For more details about which buttons will appear depending on the mode, =
please
>  review the laptop's user guide:
> @@ -1382,13 +1451,13 @@ Multiple Commands, Module Parameters
>  ------------------------------------
>
>  Multiple commands can be written to the proc files in one shot by
> -separating them with commas, for example:
> +separating them with commas, for example::
>
>         echo enable,0xffff > /proc/acpi/ibm/hotkey
>         echo lcd_disable,crt_enable > /proc/acpi/ibm/video
>
>  Commands can also be specified when loading the thinkpad-acpi module,
> -for example:
> +for example::
>
>         modprobe thinkpad_acpi hotkey=3Denable,0xffff video=3Dauto_disabl=
e
>
> @@ -1397,14 +1466,16 @@ Enabling debugging output
>  -------------------------
>
>  The module takes a debug parameter which can be used to selectively
> -enable various classes of debugging output, for example:
> +enable various classes of debugging output, for example::
>
>          modprobe thinkpad_acpi debug=3D0xffff
>
>  will enable all debugging output classes.  It takes a bitmask, so
>  to enable more than one output class, just add their values.
>
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>         Debug bitmask           Description
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>         0x8000                  Disclose PID of userspace programs
>                                 accessing some functions of the driver
>         0x0001                  Initialization and probing
> @@ -1415,6 +1486,7 @@ to enable more than one output class, just add thei=
r values.
>         0x0010                  Fan control
>         0x0020                  Backlight brightness
>         0x0040                  Audio mixer/volume control
> +       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
>  There is also a kernel build option to enable more debugging
>  information, which may be necessary to debug driver problems.
> @@ -1432,8 +1504,10 @@ the module parameter force_load=3D1.  Regardless o=
f whether this works or
>  not, please contact ibm-acpi-devel@lists.sourceforge.net with a report.
>
>
> -Sysfs interface changelog:
> +Sysfs interface changelog
> +^^^^^^^^^^^^^^^^^^^^^^^^^
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  0x000100:      Initial sysfs support, as a single platform driver and
>                 device.
>  0x000200:      Hot key support for 32 hot keys, and radio slider switch
> @@ -1485,3 +1559,4 @@ Sysfs interface changelog:
>  0x030000:      Thermal and fan sysfs attributes were moved to the hwmon
>                 device instead of being attached to the backing platform
>                 device.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/laptops/toshiba_haps.txt b/Documentation/lapto=
ps/toshiba_haps.rst
> similarity index 60%
> rename from Documentation/laptops/toshiba_haps.txt
> rename to Documentation/laptops/toshiba_haps.rst
> index 0c1d88dedbde..11dfc428c080 100644
> --- a/Documentation/laptops/toshiba_haps.txt
> +++ b/Documentation/laptops/toshiba_haps.rst
> @@ -1,18 +1,19 @@
> -Kernel driver toshiba_haps
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Toshiba HDD Active Protection Sensor
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> +Kernel driver: toshiba_haps
> +
>  Author: Azael Avalos <coproscefalo@gmail.com>
>
>
> -0. Contents
> ------------
> +.. 0. Contents
>
> -1. Description
> -2. Interface
> -3. Accelerometer axes
> -4. Supported devices
> -5. Usage
> +   1. Description
> +   2. Interface
> +   3. Accelerometer axes
> +   4. Supported devices
> +   5. Usage
>
>
>  1. Description
> @@ -32,17 +33,20 @@ file to set the desired protection level or sensor se=
nsibility.
>  ------------
>
>  This device comes with 3 methods:
> -_STA -  Checks existence of the device, returning Zero if the device doe=
s not
> +
> +=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +_STA    Checks existence of the device, returning Zero if the device doe=
s not
>         exists or is not supported.
> -PTLV -  Sets the desired protection level.
> -RSSS -  Shuts down the HDD protection interface for a few seconds,
> +PTLV    Sets the desired protection level.
> +RSSS    Shuts down the HDD protection interface for a few seconds,
>         then restores normal operation.
> +=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Note:
> -The presence of Solid State Drives (SSD) can make this driver to fail lo=
ading,
> -given the fact that such drives have no movable parts, and thus, not req=
uiring
> -any "protection" as well as failing during the evaluation of the _STA me=
thod
> -found under this device.
> +  The presence of Solid State Drives (SSD) can make this driver to fail =
loading,
> +  given the fact that such drives have no movable parts, and thus, not r=
equiring
> +  any "protection" as well as failing during the evaluation of the _STA =
method
> +  found under this device.
>
>
>  3. Accelerometer axes
> @@ -66,11 +70,18 @@ conventional HDD and not only SSD, or a combination o=
f both HDD and SSD.
>  --------
>
>  The sysfs files under /sys/devices/LNXSYSTM:00/LNXSYBUS:00/TOS620A:00/ a=
re:
> -protection_level - The protection_level is readable and writeable, and
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +protection_level   The protection_level is readable and writeable, and
>                    provides a way to let userspace query the current prot=
ection
>                    level, as well as set the desired protection level, th=
e
>                    available protection levels are:
> -                  0 - Disabled | 1 - Low | 2 - Medium | 3 - High
> -reset_protection - The reset_protection entry is writeable only, being "=
1"
> +
> +                  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=
=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D
> +                  0 - Disabled   1 - Low   2 - Medium   3 - High
> +                  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=
=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D
> +
> +reset_protection   The reset_protection entry is writeable only, being "=
1"
>                    the only parameter it accepts, it is used to trigger
>                    a reset of the protection interface.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
> index 749322060f10..c5f0d44433a2 100644
> --- a/Documentation/sysctl/vm.txt
> +++ b/Documentation/sysctl/vm.txt
> @@ -102,7 +102,7 @@ Changing this takes effect whenever an application re=
quests memory.
>  block_dump
>
>  block_dump enables block I/O debugging when set to a nonzero value. More
> -information on block I/O debugging is in Documentation/laptops/laptop-mo=
de.txt.
> +information on block I/O debugging is in Documentation/laptops/laptop-mo=
de.rst.
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -286,7 +286,7 @@ shared memory segment using hugetlb page.
>  laptop_mode
>
>  laptop_mode is a knob that controls "laptop mode". All the things that a=
re
> -controlled by this knob are discussed in Documentation/laptops/laptop-mo=
de.txt.
> +controlled by this knob are discussed in Documentation/laptops/laptop-mo=
de.rst.
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73000e7d7f19..c63b1b9cbed4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14753,7 +14753,7 @@ M:      Mattia Dongili <malattia@linux.it>
>  L:     platform-driver-x86@vger.kernel.org
>  W:     http://www.linux.it/~malattia/wiki/index.php/Sony_drivers
>  S:     Maintained
> -F:     Documentation/laptops/sony-laptop.txt
> +F:     Documentation/laptops/sony-laptop.rst
>  F:     drivers/char/sonypi.c
>  F:     drivers/platform/x86/sony-laptop.c
>  F:     include/linux/sony-laptop.h
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 466ebd84ad17..bb734066075f 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -382,7 +382,7 @@ config SONYPI
>           Device which can be found in many (all ?) Sony Vaio laptops.
>
>           If you have one of those laptops, read
> -         <file:Documentation/laptops/sonypi.txt>, and say Y or M here.
> +         <file:Documentation/laptops/sonypi.rst>, and say Y or M here.
>
>           To compile this driver as a module, choose M here: the
>           module will be called sonypi.
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5d5cc6111081..e53c915761e7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -451,7 +451,7 @@ config SONY_LAPTOP
>           screen brightness control, Fn keys and allows powering on/off s=
ome
>           devices.
>
> -         Read <file:Documentation/laptops/sony-laptop.txt> for more info=
rmation.
> +         Read <file:Documentation/laptops/sony-laptop.rst> for more info=
rmation.
>
>  config SONYPI_COMPAT
>         bool "Sonypi compatibility"
> @@ -503,7 +503,7 @@ config THINKPAD_ACPI
>           support for Fn-Fx key combinations, Bluetooth control, video
>           output switching, ThinkLight control, UltraBay eject and more.
>           For more information about this driver see
> -         <file:Documentation/laptops/thinkpad-acpi.txt> and
> +         <file:Documentation/laptops/thinkpad-acpi.rst> and
>           <http://ibm-acpi.sf.net/> .
>
>           This driver was formerly known as ibm-acpi.
> --
> 2.21.0
>


--=20
With Best Regards,
Andy Shevchenko
