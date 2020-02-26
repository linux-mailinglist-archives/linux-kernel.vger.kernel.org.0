Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEADA16FE29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 12:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgBZLqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 06:46:08 -0500
Received: from foss.arm.com ([217.140.110.172]:34672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgBZLqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:46:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0C551FB;
        Wed, 26 Feb 2020 03:46:04 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 350313FA00;
        Wed, 26 Feb 2020 03:46:03 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:46:01 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] arch: arm64: xilinx: Make zynqmp_firmware driver optional
Message-ID: <20200226114601.GB8613@bogus>
References: <1582675460-26914-1-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582675460-26914-1-git-send-email-jolly.shah@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 04:04:20PM -0800, Jolly Shah wrote:
> From: Tejas Patel <tejas.patel@xilinx.com>
>
> Make zynqmp_firmware driver as optional to disable it, if user don't
> want to use default zynqmp firmware interface.
>

This patch on it own is simple and looks fine. However I expect the
single binary to work with and without this option on the same platform.
If zynqmp_firmware is not critical, the system should continue to work
fine either way. The zynqmp_firmware driver should gracefully exit with
error(if any).

--
Regards,
Sudeep
