Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63CF74F3F3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 08:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfFVGBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 02:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfFVGBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:01:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442002070B;
        Sat, 22 Jun 2019 06:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561183299;
        bh=J4nwTNf4TIc77OEmvYy2wd0rsAPfND411jSD0FcgEwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGFNm22Dllq5iqArZAVGhwDzlZNbmVJOLcw3Q9yawbOQKMjih0GV7VZhFwNePb0hn
         inZi6PMD9sbUtc8/bl/LH9ZqUPohCCSW4Lhx5xf+2KpTa54EyGd26OZI2JA5pk2DH1
         ImnCX/JHnz0tV2ynOLdB9QwAUkfALEY8Ohf0bJIA=
Date:   Sat, 22 Jun 2019 08:01:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: Re: [PATCH V7 00/11] misc: xilinx sd-fec drive
Message-ID: <20190622060135.GB26200@kroah.com>
References: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
 <20190621141553.GA16650@kroah.com>
 <CH2PR02MB635999D7374378CEA096FE72CBE70@CH2PR02MB6359.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR02MB635999D7374378CEA096FE72CBE70@CH2PR02MB6359.namprd02.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:49:45PM +0000, Dragan Cvetic wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Friday 21 June 2019 15:16
> > To: Dragan Cvetic <draganc@xilinx.com>
> > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; robh+dt@kernel.org;
> > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > Subject: Re: [PATCH V7 00/11] misc: xilinx sd-fec drive
> > 
> > On Tue, Jun 11, 2019 at 06:29:34PM +0100, Dragan Cvetic wrote:
> > > This patchset is adding the full Soft Decision Forward Error
> > > Correction (SD-FEC) driver implementation, driver DT binding and
> > > driver documentation.
> > >
> > > Forward Error Correction (FEC) codes such as Low Density Parity
> > > Check (LDPC) and turbo codes provide a means to control errors in
> > > data transmissions over unreliable or noisy communication
> > > channels. The SD-FEC Integrated Block is an optimized block for
> > > soft-decision decoding of these codes. Fixed turbo codes are
> > > supported directly, whereas custom and standardized LDPC codes
> > > are supported through the ability to specify the parity check
> > > matrix through an AXI4-Lite bus or using the optional programmable
> > > (PL)-based support logic. For the further information see
> > > https://www.xilinx.com/support/documentation/ip_documentation/
> > > sd_fec/v1_1/pg256-sdfec-integrated-block.pdf
> > >
> > > This driver is a platform device driver which supports SDFEC16
> > > (16nm) IP. SD-FEC driver supports LDPC decoding and encoding and
> > > Turbo code decoding. LDPC codes can be specified on
> > > a codeword-by-codeword basis, also a custom LDPC code can be used.
> > >
> > > The SD-FEC driver exposes a char device interface and supports
> > > file operations: open(), close(), poll() and ioctl(). The driver
> > > allows only one usage of the device, open() limits the number of
> > > driver instances. The driver also utilize Common Clock Framework
> > > (CCF).
> > >
> > > The control and monitoring is supported over ioctl system call.
> > > The features supported by ioctl():
> > > - enable or disable data pipes to/from device
> > > - configure the FEC algorithm parameters
> > > - set the order of data
> > > - provide a control of a SDFEC bypass option
> > > - activates/deactivates SD-FEC
> > > - collect and provide statistical data
> > > - enable/disable interrupt mode
> > 
> > Is there any userspace tool that talks to this device using these custom
> > ioctls yet?
> > 
> Tools no, but could be the customer who is using the driver.

I don't understand this.  Who has written code to talk to these
special ioctls from userspace?  Is there a pointer to that code
anywhere?

> > Doing a one-off ioctl api is always a risky thing, you are pretty much
> > just creating brand new system calls for one piece of hardware.
> > 
> 
> Why is that wrong and what is the risk?

You now have custom syscalls for one specfic piece of hardware that you
now have to maintain working properly for the next 40+ years.  You have
to make sure those calls are correct and that this is the correct api to
talk to this hardware.

> What would you propose?
> Definitely, I have to read about this.

What is this hardware and what is it used for?  Who will be talking to
it from userspace?  What userspace workload uses it?  What tools need to
talk to it?  Where is the code that uses these new apis?

thanks,

greg k-h
