Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6D1623B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 10:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgBRJn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 04:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgBRJn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:43:59 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A37B7206E2;
        Tue, 18 Feb 2020 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582019038;
        bh=glEd8LJg33O82qVtAetCni+HqVd9K5Kd0qvxg1Lw4x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnC8as/2IqxRU9Yof3Riunpd5ghLEMkDOCHPGVqmZ92/AY3wlU0/16p4BSv3F/2P3
         jZ0OwMQ+mStgxWyfe79suW0thBq9gNYEgONjCXPQKAtG9hNsK/5rVxLXcxWyEUlkOS
         qeALyMVj3ieInr8CvOc2QiBSjnZ3iKyF6ieeZkEk=
Date:   Tue, 18 Feb 2020 17:43:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 RESEND 1/7] ARM: dts: imx6sx: Improve UART pins macro
 defines
Message-ID: <20200218094351.GE6075@dragon>
References: <1581938021-16259-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581938021-16259-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 07:13:35PM +0800, Anson Huang wrote:
> Add DCE/DTE to UART pins macro defines to distinguish the
> DCE and DTE functions, keep old defines at the end of file
> for some time to make it backward compatible.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied all, thanks.
