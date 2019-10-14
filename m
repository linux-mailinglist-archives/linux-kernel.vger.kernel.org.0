Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A6CD6426
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 15:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfJNNeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 09:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfJNNeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:34:10 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5739A20873;
        Mon, 14 Oct 2019 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571060049;
        bh=IjCmDtTQCKTJYyKqcpgE5FEMEpY8OPsh0gh30lGNZ2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuoS1P9tI+itJbp3R66cC5VCB92p2BFDi/ULGQKp1D8A/6/MhTJocE5ocIaCbrfkG
         5Fn0H9RonBiRB0Fc/LHmqj5ibEnwCcgFkb9cRq7bIxBapbpx+NLSVWwHOZy+oYMC9e
         TE/fjBl6M6W16bQTuEgU6wbhOCw6lLHfgp/qNESA=
Date:   Mon, 14 Oct 2019 21:33:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        ccaione@baylibre.com, abel.vesa@nxp.com, daniel.baluta@nxp.com,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq-evk: Adjust nodes following
 alphabetical sort
Message-ID: <20191014133343.GA12262@dragon>
References: <1570588479-28009-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570588479-28009-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:34:38AM +0800, Anson Huang wrote:
> Adjust some nodes to make them follow alphabetical sort except
> iomuxc node which is put at the end of file because of its huge
> pinctrl data.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
