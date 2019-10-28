Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C564E70E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 13:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbfJ1MEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 08:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388739AbfJ1MEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:04:37 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0E32086D;
        Mon, 28 Oct 2019 12:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572264276;
        bh=zyG5Y+J760QevxoHDxz7mE1bnyRmrOKKPhZ5PA7C9rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvrCWX5eXTpSwK7e8QkRd6CBhvJLmx0M6tlFpxLkdQgcAGypUr9zCSZhlK8QncFFo
         hTmQPJflORixz9sWSMg6F+lETVDM1LavajrkTe0GsObFqddORwrEwYIJLgK3/bbldk
         T9rmdaclD8KTYVCtZFTg83lASTsYeh3WAuiZyr4E=
Date:   Mon, 28 Oct 2019 20:04:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        leonard.crestez@nxp.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] soc: imx8: Using existing serial_number instead of
 UID
Message-ID: <20191028120411.GI16985@dragon>
References: <1571986583-21138-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571986583-21138-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 02:56:22PM +0800, Anson Huang wrote:
> The soc_device_attribute structure already contains a serial_number
> attribute to show SoC's unique ID, just use it to show SoC's unique
> ID instead of creating a new file called soc_uid.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
