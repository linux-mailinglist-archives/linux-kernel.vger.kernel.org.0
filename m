Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3449F15B4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 00:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgBLXox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 18:44:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLXow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:44:52 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F90E206B6;
        Wed, 12 Feb 2020 23:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581551092;
        bh=1M3lO/lf9AWfvIAE3n4hv4ebm9MsTlrPuI3pVt0XwiI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gKNmOOaSejM7SuOkKHEMPhUSEUcyDAyifJf7mJT5rapx5BcH6wMPBNWB+oG4mmjET
         2x/6JgGAIVsMk6Pk35WyNYIXY6DkSk5SnurlOnEoCI3dt6Kn0CivuXKQ+wdi+ZRdTY
         DaWev8mu0p5NdeznMlDVKHnePkgFoCvSZwd8lHjI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
References: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
Subject: Re: [PATCH v7 0/7] Add basic SoC support for mt6765
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Joerg Roedel <jroedel@suse.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        mtk01761 <wendell.lin@mediatek.com>
Date:   Wed, 12 Feb 2020 15:44:51 -0800
Message-ID: <158155109134.184098.10100489231587620578@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Macpaul Lin (2020-02-07 01:20:43)
> This patch adds basic SoC support for Mediatek's new 8-core SoC,
> MT6765, which is mainly for smartphone application.

Clock patches look OK to me. Can you resend them without the defconfig
and dts patches and address Matthias' question?
