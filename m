Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC42791C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfEWJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 05:21:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43875 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfEWJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:21:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id z5so4756903lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 02:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4XcqDUatAfmgljf2N/1mh+oZ/fVlYQkb3Eap4X4ce+M=;
        b=BNaKcsBteXU+ks20RJyqyLmzLLohFN17AYcI7vQtQbiUfofuDTgaeVWyT9DBO0YD/0
         eauTZH8Orvr2KG6U6HFIMxscVT0p8fjvI5X5/ZQ5pYDbsdcNYPOHUXLI01ZMf0/CYT9l
         tScr2mPBRVKPtB3omxhdKTTVkITVre5Ndve8vAP3MbtB8iPbdAlM8GQs+dphgqfICFxG
         21deGjxHfsv+Hb1XbPbGR29MxDyh1XopKzwI8wUmYmwv/evxagwbScc4/RfAEJiRt9Rz
         E0iFqVynk2fesKH/0plVFBITrp1crP+H6q2kwLjT1FRrby6HitdwdHIhMQ1MND7lPXoo
         mgGQ==
X-Gm-Message-State: APjAAAV/VDaeUrZQLy/vySSbR3gRzz/ATSsuNMoopp1zHNZM23FqnA3f
        UDTsHAGw/8q0Nh7OUWsxTSM=
X-Google-Smtp-Source: APXvYqyTeIM6shvmPxNKEaSRJpKoi0EcJbryv8vE5BbUFw8v/fsgjQfjM7mduoYY9EObKZOPoJPkwg==
X-Received: by 2002:a2e:874b:: with SMTP id q11mr19806056ljj.48.1558603292197;
        Thu, 23 May 2019 02:21:32 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l16sm6660589ljg.90.2019.05.23.02.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 02:21:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hTjuh-0002IK-33; Thu, 23 May 2019 11:21:27 +0200
Date:   Thu, 23 May 2019 11:21:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/3] tty: drop unused iflag macro
Message-ID: <20190523092127.GD568@localhost>
References: <20190426055925.13430-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426055925.13430-1-johan@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 07:59:22AM +0200, Johan Hovold wrote:
> I noticed that the RELEVANT_IFLAG() macro was unused in USB serial and
> turns out there were a few more instances that could be dropped.
> 
> I have some pending changes that may conflict with the corresponding
> change to USB serial so I'll take that one separately through my tree,
> but perhaps the rest could go through Greg's tty tree.

> Johan Hovold (3):
>   tty: simserial: drop unused iflag macro
>   tty: ipoctal: drop unused iflag macro
>   tty: cpm_uart: drop unused iflag macro
> 
>  arch/ia64/hp/sim/simserial.c                | 2 --
>  drivers/ipack/devices/ipoctal.h             | 1 -
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 --
>  3 files changed, 5 deletions(-)

Greg, do you still have these clean-ups in your queue? Want me to resend
with Tony's ack?

Johan
