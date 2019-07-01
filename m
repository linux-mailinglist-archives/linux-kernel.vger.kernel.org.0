Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458464D89F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfFTSEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 14:04:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42982 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfFTSEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:04:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so2091219pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eeYksFC5bt6kiVdAbFedq6qCS3XlPoN6i4fJKtdvyCM=;
        b=jwhZ/rI+IcvOS4nZZBlv3novWW37LkMGbFrbpwH5in3K0Pams6fgXfQsB8sELYsbze
         vWxczMChKERfQnJZ1Dxd4aC0e17UZqZfAdvJMwJHRdQHL0vy+gY9iw45d8HZ2+brqWFm
         7Mcyh9QZoW5xVwq1mxOPw4dMGmH1sgFWIQzbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eeYksFC5bt6kiVdAbFedq6qCS3XlPoN6i4fJKtdvyCM=;
        b=NWMvT4/7ZDVjgBb4+3TKcxDicWUvlAIfIa3tk1vTgbQ2mhf33RebgGxivmjnyznqus
         b4VF17LN6yAl9FAajFcG758k4Ay4/uxwtqWz+5cSsdW+J224lrVLMvgR+WY1UCZ6FOix
         UmG54aOrBLDvXdboXYcUW5JRXOGfhq4xnG71PqyqACFnMLhXtMeJDEOZImAUy/uaoyoX
         6s1TgnPXY1I3N7eTp90q1IOG8Q/WeROtOvlEIbw224GQa+Fn5139FJAz5VvLDhUPdYLV
         SE63Bc8U5UPCUVqhcgJFfW68KTlhXOPfL3YobGXbAtsJi8Ab1l6j7Zx00sgtwGRmGWm6
         V+SQ==
X-Gm-Message-State: APjAAAWRGSF6xJsRhJliHepwphfytxUS22w9xJjpsDfFO6Dyn70FwsBk
        7r6C86l1HfMgmiLAOPLHoPSiWQ==
X-Google-Smtp-Source: APXvYqwi/eM20h25I96iO7pnLncqXPQ9ksp4561nAhg3s9aUEQdyzHi6iaGUGXujVI7bBGdBJX//UA==
X-Received: by 2002:a17:90a:f498:: with SMTP id bx24mr923054pjb.91.1561053859491;
        Thu, 20 Jun 2019 11:04:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s64sm118328pfb.160.2019.06.20.11.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 11:04:18 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:04:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 02/22] ABI: Fix KernelVersion tags
Message-ID: <201906201103.6A6F68B9@keescook>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
 <08110b8914ae2ac61e5b284f7488475a3c761f4b.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08110b8914ae2ac61e5b284f7488475a3c761f4b.1561050806.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 02:22:54PM -0300, Mauro Carvalho Chehab wrote:
> It is "KernelVersion:" and not "Kernel Version:".
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/ABI/testing/pstore              |  2 +-
>  .../sysfs-bus-event_source-devices-format     |  2 +-
>  .../ABI/testing/sysfs-bus-i2c-devices-hm6352  |  6 ++---
>  .../testing/sysfs-bus-pci-devices-aer_stats   | 12 +++++-----
>  .../ABI/testing/sysfs-bus-pci-devices-cciss   | 22 +++++++++----------
>  .../testing/sysfs-bus-usb-devices-usbsevseg   | 10 ++++-----
>  .../ABI/testing/sysfs-driver-altera-cvp       |  2 +-
>  Documentation/ABI/testing/sysfs-driver-ppi    |  2 +-
>  Documentation/ABI/testing/sysfs-driver-st     |  2 +-
>  Documentation/ABI/testing/sysfs-driver-wacom  |  2 +-
>  10 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/pstore b/Documentation/ABI/testing/pstore
> index 8d6e48f4e8ef..d45209abdb1b 100644
> --- a/Documentation/ABI/testing/pstore
> +++ b/Documentation/ABI/testing/pstore
> @@ -1,6 +1,6 @@
>  What:		/sys/fs/pstore/... (or /dev/pstore/...)
>  Date:		March 2011
> -Kernel Version: 2.6.39
> +KernelVersion: 2.6.39
>  Contact:	tony.luck@intel.com
>  Description:	Generic interface to platform dependent persistent storage.
>  
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
> index b6f8748e0200..5bb793ec926c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
> @@ -1,6 +1,6 @@
>  What:		/sys/bus/event_source/devices/<dev>/format
>  Date:		January 2012
> -Kernel Version: 3.3
> +KernelVersion: 3.3
>  Contact:	Jiri Olsa <jolsa@redhat.com>
>  Description:
>  		Attribute group to describe the magic bits that go into
> diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352 b/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
> index 29bd447e50a0..4a251b7f11e4 100644
> --- a/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
> +++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
> @@ -1,20 +1,20 @@
>  What:		/sys/bus/i2c/devices/.../heading0_input
>  Date:		April 2010
> -Kernel Version: 2.6.36?
> +KernelVersion: 2.6.36?
>  Contact:	alan.cox@intel.com
>  Description:	Reports the current heading from the compass as a floating
>  		point value in degrees.
>  
>  What:		/sys/bus/i2c/devices/.../power_state
>  Date:		April 2010
> -Kernel Version: 2.6.36?
> +KernelVersion: 2.6.36?
>  Contact:	alan.cox@intel.com
>  Description:	Sets the power state of the device. 0 sets the device into
>  		sleep mode, 1 wakes it up.
>  
>  What:		/sys/bus/i2c/devices/.../calibration
>  Date:		April 2010
> -Kernel Version: 2.6.36?
> +KernelVersion: 2.6.36?
>  Contact:	alan.cox@intel.com
>  Description:	Sets the calibration on or off (1 = on, 0 = off). See the
>  		chip data sheet.
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> index ff229d71961c..3c9a8c4a25eb 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> @@ -11,7 +11,7 @@ saw any problems).
>  
>  What:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
>  Date:		July 2018
> -Kernel Version: 4.19.0
> +KernelVersion: 4.19.0
>  Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>  Description:	List of correctable errors seen and reported by this
>  		PCI device using ERR_COR. Note that since multiple errors may
> @@ -33,7 +33,7 @@ TOTAL_ERR_COR 2
>  
>  What:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
>  Date:		July 2018
> -Kernel Version: 4.19.0
> +KernelVersion: 4.19.0
>  Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>  Description:	List of uncorrectable fatal errors seen and reported by this
>  		PCI device using ERR_FATAL. Note that since multiple errors may
> @@ -64,7 +64,7 @@ TOTAL_ERR_FATAL 0
>  
>  What:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
>  Date:		July 2018
> -Kernel Version: 4.19.0
> +KernelVersion: 4.19.0
>  Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>  Description:	List of uncorrectable nonfatal errors seen and reported by this
>  		PCI device using ERR_NONFATAL. Note that since multiple errors
> @@ -105,18 +105,18 @@ messages on the PCI hierarchy originating at that root port.
>  
>  What:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
>  Date:		July 2018
> -Kernel Version: 4.19.0
> +KernelVersion: 4.19.0
>  Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>  Description:	Total number of ERR_COR messages reported to rootport.
>  
>  What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
>  Date:		July 2018
> -Kernel Version: 4.19.0
> +KernelVersion: 4.19.0
>  Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>  Description:	Total number of ERR_FATAL messages reported to rootport.
>  
>  What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
>  Date:		July 2018
> -Kernel Version: 4.19.0
> +KernelVersion: 4.19.0
>  Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>  Description:	Total number of ERR_NONFATAL messages reported to rootport.
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss b/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
> index eb449169c30b..92a94e1068c2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
> @@ -1,68 +1,68 @@
>  What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/model
>  Date:		March 2009
> -Kernel Version: 2.6.30
> +KernelVersion: 2.6.30
>  Contact:	iss_storagedev@hp.com
>  Description:	Displays the SCSI INQUIRY page 0 model for logical drive
>  		Y of controller X.
>  
>  What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/rev
>  Date:		March 2009
> -Kernel Version: 2.6.30
> +KernelVersion: 2.6.30
>  Contact:	iss_storagedev@hp.com
>  Description:	Displays the SCSI INQUIRY page 0 revision for logical
>  		drive Y of controller X.
>  
>  What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/unique_id
>  Date:		March 2009
> -Kernel Version: 2.6.30
> +KernelVersion: 2.6.30
>  Contact:	iss_storagedev@hp.com
>  Description:	Displays the SCSI INQUIRY page 83 serial number for logical
>  		drive Y of controller X.
>  
>  What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/vendor
>  Date:		March 2009
> -Kernel Version: 2.6.30
> +KernelVersion: 2.6.30
>  Contact:	iss_storagedev@hp.com
>  Description:	Displays the SCSI INQUIRY page 0 vendor for logical drive
>  		Y of controller X.
>  
>  What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/block:cciss!cXdY
>  Date:		March 2009
> -Kernel Version: 2.6.30
> +KernelVersion: 2.6.30
>  Contact:	iss_storagedev@hp.com
>  Description:	A symbolic link to /sys/block/cciss!cXdY
>  
>  What:		/sys/bus/pci/devices/<dev>/ccissX/rescan
>  Date:		August 2009
> -Kernel Version:	2.6.31
> +KernelVersion:	2.6.31
>  Contact:	iss_storagedev@hp.com
>  Description:	Kicks of a rescan of the controller to discover logical
>  		drive topology changes.
>  
>  What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/lunid
>  Date:		August 2009
> -Kernel Version: 2.6.31
> +KernelVersion: 2.6.31
>  Contact:	iss_storagedev@hp.com
>  Description:	Displays the 8-byte LUN ID used to address logical
>  		drive Y of controller X.
>  
>  What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/raid_level
>  Date:		August 2009
> -Kernel Version: 2.6.31
> +KernelVersion: 2.6.31
>  Contact:	iss_storagedev@hp.com
>  Description:	Displays the RAID level of logical drive Y of
>  		controller X.
>  
>  What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/usage_count
>  Date:		August 2009
> -Kernel Version: 2.6.31
> +KernelVersion: 2.6.31
>  Contact:	iss_storagedev@hp.com
>  Description:	Displays the usage count (number of opens) of logical drive Y
>  		of controller X.
>  
>  What:		/sys/bus/pci/devices/<dev>/ccissX/resettable
>  Date:		February 2011
> -Kernel Version:	2.6.38
> +KernelVersion:	2.6.38
>  Contact:	iss_storagedev@hp.com
>  Description:	Value of 1 indicates the controller can honor the reset_devices
>  		kernel parameter.  Value of 0 indicates reset_devices cannot be
> @@ -73,7 +73,7 @@ Description:	Value of 1 indicates the controller can honor the reset_devices
>  
>  What:		/sys/bus/pci/devices/<dev>/ccissX/transport_mode
>  Date:		July 2011
> -Kernel Version:	3.0
> +KernelVersion:	3.0
>  Contact:	iss_storagedev@hp.com
>  Description:	Value of "simple" indicates that the controller has been placed
>  		in "simple mode". Value of "performant" indicates that the
> diff --git a/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg b/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
> index f6199b314196..9ade80f81f96 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
> +++ b/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
> @@ -1,6 +1,6 @@
>  What:		/sys/bus/usb/.../powered
>  Date:		August 2008
> -Kernel Version:	2.6.26
> +KernelVersion:	2.6.26
>  Contact:	Harrison Metzger <harrisonmetz@gmail.com>
>  Description:	Controls whether the device's display will powered.
>  		A value of 0 is off and a non-zero value is on.
> @@ -8,7 +8,7 @@ Description:	Controls whether the device's display will powered.
>  What:		/sys/bus/usb/.../mode_msb
>  What:		/sys/bus/usb/.../mode_lsb
>  Date:		August 2008
> -Kernel Version:	2.6.26
> +KernelVersion:	2.6.26
>  Contact:	Harrison Metzger <harrisonmetz@gmail.com>
>  Description:	Controls the devices display mode.
>  		For a 6 character display the values are
> @@ -18,7 +18,7 @@ Description:	Controls the devices display mode.
>  
>  What:		/sys/bus/usb/.../textmode
>  Date:		August 2008
> -Kernel Version:	2.6.26
> +KernelVersion:	2.6.26
>  Contact:	Harrison Metzger <harrisonmetz@gmail.com>
>  Description:	Controls the way the device interprets its text buffer.
>  		raw:	each character controls its segment manually
> @@ -27,13 +27,13 @@ Description:	Controls the way the device interprets its text buffer.
>  
>  What:		/sys/bus/usb/.../text
>  Date:		August 2008
> -Kernel Version:	2.6.26
> +KernelVersion:	2.6.26
>  Contact:	Harrison Metzger <harrisonmetz@gmail.com>
>  Description:	The text (or data) for the device to display
>  
>  What:		/sys/bus/usb/.../decimals
>  Date:		August 2008
> -Kernel Version:	2.6.26
> +KernelVersion:	2.6.26
>  Contact:	Harrison Metzger <harrisonmetz@gmail.com>
>  Description:	Controls the decimal places on the device.
>  		To set the nth decimal place, give this field
> diff --git a/Documentation/ABI/testing/sysfs-driver-altera-cvp b/Documentation/ABI/testing/sysfs-driver-altera-cvp
> index 8cde64a71edb..fbd8078fd7ad 100644
> --- a/Documentation/ABI/testing/sysfs-driver-altera-cvp
> +++ b/Documentation/ABI/testing/sysfs-driver-altera-cvp
> @@ -1,6 +1,6 @@
>  What:		/sys/bus/pci/drivers/altera-cvp/chkcfg
>  Date:		May 2017
> -Kernel Version:	4.13
> +KernelVersion:	4.13
>  Contact:	Anatolij Gustschin <agust@denx.de>
>  Description:
>  		Contains either 1 or 0 and controls if configuration
> diff --git a/Documentation/ABI/testing/sysfs-driver-ppi b/Documentation/ABI/testing/sysfs-driver-ppi
> index 9921ef285899..1a56fc507689 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ppi
> +++ b/Documentation/ABI/testing/sysfs-driver-ppi
> @@ -1,6 +1,6 @@
>  What:		/sys/class/tpm/tpmX/ppi/
>  Date:		August 2012
> -Kernel Version:	3.6
> +KernelVersion:	3.6
>  Contact:	xiaoyan.zhang@intel.com
>  Description:
>  		This folder includes the attributes related with PPI (Physical
> diff --git a/Documentation/ABI/testing/sysfs-driver-st b/Documentation/ABI/testing/sysfs-driver-st
> index ba5d77008a85..88cab66fd77f 100644
> --- a/Documentation/ABI/testing/sysfs-driver-st
> +++ b/Documentation/ABI/testing/sysfs-driver-st
> @@ -1,6 +1,6 @@
>  What:		/sys/bus/scsi/drivers/st/debug_flag
>  Date:		October 2015
> -Kernel Version:	?.?
> +KernelVersion:	?.?
>  Contact:	shane.seymour@hpe.com
>  Description:
>  		This file allows you to turn debug output from the st driver
> diff --git a/Documentation/ABI/testing/sysfs-driver-wacom b/Documentation/ABI/testing/sysfs-driver-wacom
> index 2aa5503ee200..afc48fc163b5 100644
> --- a/Documentation/ABI/testing/sysfs-driver-wacom
> +++ b/Documentation/ABI/testing/sysfs-driver-wacom
> @@ -1,6 +1,6 @@
>  What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/speed
>  Date:		April 2010
> -Kernel Version:	2.6.35
> +KernelVersion:	2.6.35
>  Contact:	linux-bluetooth@vger.kernel.org
>  Description:
>  		The /sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/speed file
> -- 
> 2.21.0
> 

-- 
Kees Cook
