Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3F3136C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 12:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgAJLyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 06:54:19 -0500
Received: from foss.arm.com ([217.140.110.172]:43054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbgAJLyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:54:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF7481063;
        Fri, 10 Jan 2020 03:54:18 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 360BF3F534;
        Fri, 10 Jan 2020 03:54:17 -0800 (PST)
Date:   Fri, 10 Jan 2020 11:54:15 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: Re: [PATCH 0/2] arch: arm64: xilinx: Make zynqmp_firmware driver
 optional
Message-ID: <20200110115415.GC39451@bogus>
References: <1578596764-29351-1-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578596764-29351-1-git-send-email-jolly.shah@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 11:06:02AM -0800, Jolly Shah wrote:
> From: Tejas Patel <tejas.patel@xilinx.com>
>
> Zynqmp firmware driver requires firmware to be present in system.
> Zynqmp firmware driver will crash if firmware is not present in system.
> For example single arch QEMU, may not have firmware, with such setup
> Linux booting fails.
>
> So make zynqmp_firmware driver as optional to disable it if user don't
> have firmware in system.
>

Why can't it be detected runtime ? How do you handle single binary if you
make this compile time option ?

--
Regards,
Sudeep
