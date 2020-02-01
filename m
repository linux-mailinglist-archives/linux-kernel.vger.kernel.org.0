Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FEF14F806
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 15:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBAOKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 09:10:05 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:41895 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgBAOKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 09:10:05 -0500
Received: by mail-lf1-f50.google.com with SMTP id m30so6749601lfp.8;
        Sat, 01 Feb 2020 06:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=le1pAuTbbJ6ruQLayEtuDvEi/eU1A9M5o9CD90Uw478=;
        b=YuzHtwLDg7Ai2kNVsjG6XxWS3OfhnHb8nzvgQwJISNnEMS+1WeKzbG7f6OE47pAoZA
         ns/dlXw1kcs1QIe6dwhpknCuzdxVICHdtlKJBxPBpJ2mAmuG073I76n9L6c3BhLnn0Gn
         sQ+MFiiOKbJA34XRotapQozklRPv9jlGIjgx+P6lPGp22DnyZUE/WEk3n2yLQGatS8li
         fDj/b7TN5YM7zj0zOTb9X5eMd6qck0wQFM1fgQ2Rdo2eFhWTOkHncN+kbCT+/Kdf7sDv
         kVBqzbdEHdITNUHKvANU2BpJfOi+2Ip9PQjx3bs/o95/+xvG3GadUXc3jhZiTSy9xfc8
         GQqQ==
X-Gm-Message-State: APjAAAVQf8kbuW0/yUtkARSUIMg/Cn86nI0GX4/olBzzep21jeKQ0y6V
        0CoNF8amCSViiEGlskBOOC0=
X-Google-Smtp-Source: APXvYqzwXUxzhsSvzTCmuhexgUuqxcj8C1C2A+bfgjqcHLooPY7nCXTY3vhBDZga8qCIUv8kYTZucQ==
X-Received: by 2002:ac2:5147:: with SMTP id q7mr7822934lfd.87.1580566202781;
        Sat, 01 Feb 2020 06:10:02 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id u16sm7138852lfi.36.2020.02.01.06.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 06:10:02 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ixtTN-0007sF-UA; Sat, 01 Feb 2020 15:10:09 +0100
Date:   Sat, 1 Feb 2020 15:10:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     edes <edes@gmx.net>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel 5.4.11: problems with usb sound cards
Message-ID: <20200201141009.GK10381@localhost>
References: <20200201105829.5682c887@acme7.acmenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201105829.5682c887@acme7.acmenet>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2020 at 10:58:29AM -0300, edes wrote:
> Hello, list, I hope this is the right place to post this problem.
> 
> Changes introduced in 5.4.11 (seemingly, in drivers/usb/core/config.c)
> cause problems with at least some models of USB sound cards.
> 
> I have a Sound Devices USBPre2, a high quality sound card that until
> 5.4.10 always worked perfectly out of the box as a standard USB audio
> device.
> 
> Beginning with 5.4.11 and up to 5.5.0, when the sound card is connected,
> dmesg shows:
> 
> [ 1310.743135] usb 3-10.3: new high-speed USB device number 6 using
> xhci_hcd
> [ 1310.755472] usb 3-10.3: config 1 interface 2 altsetting 1 has
> a duplicate endpoint with address 0x85, skipping
> [ 1310.755474] usb 3-10.3: config 1 interface 2 altsetting 2 has a
> duplicate endpoint with address 0x85, skipping
> [ 1310.755852] usb 3-10.3: New USB device found, idVendor=0926,
> idProduct=0202, bcdDevice= 1.00
> [ 1310.755853] usb 3-10.3: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [ 1310.755854] usb 3-10.3: Product: USBPre2
> [ 1310.755855] usb 3-10.3: Manufacturer: Sound Devices
> [ 1310.755855] usb 3-10.3: SerialNumber: HB1116132005
> [ 1310.756803] usb 3-10.3: 1:3 : UAC_AS_GENERAL descriptor not found
> [ 1310.757550] hid-generic 0003:0926:0202.0005: hiddev96: USB HID v1.01
> Device
> [Sound Devices USBPre2] on usb-0000:00:14.0-10.3/input3
> [ 1310.773161] systemd-udevd[3856]: controlC0: Process '/usr/sbin/alsactl
> restore 0' failed with exit code 99.
> 
> No capture device is created under /dev/snd, and the card works only as a
> playback device.

Can you please post the output of "lsusb -v" for this device on 5.4.10
and 5.4.11, respectively?

Johan
