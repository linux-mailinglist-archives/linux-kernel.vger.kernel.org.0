Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC56AED751
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 02:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfKDBvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 20:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbfKDBvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:51:44 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55184217F5;
        Mon,  4 Nov 2019 01:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572832303;
        bh=i/t4E/d8x2s1PbrvEGG/bDDGFhRvRZ77Yjugxqxg3N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1dOR6SqaDADSs33+pBWSCwM5mN/zQ6ReKld+h+Ic6h0y50E5QXkAsA3F7lY82qAN
         ub4VXUWkM/uI8SFCnJKyFtnNEVAMvlgr+OHmpOZ+g9NogUkMTknJNF3Rw4BYLJ1+vy
         FVh3Q7BvkIIESgrzI20YWPkmkjvjyLf7Q07MscPc=
Date:   Mon, 4 Nov 2019 09:51:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marex@denx.de, angus@akkea.ca, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v4 3/3] ARM: dts: imx: add devicetree for Kobo Clara HD
Message-ID: <20191104015115.GL24620@dragon>
References: <20191026195748.14562-1-andreas@kemnade.info>
 <20191026195748.14562-4-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026195748.14562-4-andreas@kemnade.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 09:57:48PM +0200, Andreas Kemnade wrote:
> This adds a devicetree for the Kobo Clara HD Ebook reader. It
> is on based on boards called "e60k02". It is equipped with an
> imx6sll SoC.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks.
