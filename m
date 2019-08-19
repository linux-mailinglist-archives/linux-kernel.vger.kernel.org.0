Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6779292562
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 15:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfHSNo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 09:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfHSNo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:44:28 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F30D2082C;
        Mon, 19 Aug 2019 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566222267;
        bh=4imZlkmHzIed4Mp3/LD2nvWrJeVkEdiHucY1+JRi3Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5JY8AoOIO8cprE+CgdemQakGF2obUuLcrMtTXSH+p/iCjxN3OwOmBEToJDD9lmv/
         wbk3JQ9fTEPXZc9IR+otXItcHC8X3TJ9N7nXtUGg1DztRdozqeUBb3Yvjd/Tavk/zW
         eyQP87lIWu3/IUKr7+u7e+BRt9B5bnmJ8EW/GEo8=
Date:   Mon, 19 Aug 2019 15:44:14 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     aisheng.dong@nxp.com, anson.huang@nxp.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, m.felsch@pengutronix.de,
        mark.rutland@arm.com, paul.olaru@nxp.com, peng.fan@nxp.com,
        robh+dt@kernel.org, shengjiu.wang@nxp.com,
        sound-open-firmware@alsa-project.org,
        pierre-louis.bossart@linux.intel.com, l.stach@pengutronix.de
Subject: Re: [PATCH v3 4/5] arm64: dts: imx8qxp: Add DSP DT node
Message-ID: <20190819134413.GQ5999@X250>
References: <20190807164258.8306-1-daniel.baluta@nxp.com>
 <20190807164258.8306-5-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807164258.8306-5-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 07:42:57PM +0300, Daniel Baluta wrote:
> This includes DSP reserved memory, ADMA DSP device and DSP MU
> communication channels description.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
