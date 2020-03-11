Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6611811A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgCKHSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 03:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:18:38 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD229208C3;
        Wed, 11 Mar 2020 07:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583911118;
        bh=wYY97ZSWC5XMDItxhtR09WH1FAjk4m3O5/pXkfCmlcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zgPmNAKvzN0FOpqTCgJKjjBzGDcP2ZT9ioyvY7FsZOcgUPHuH+K5Ofg1rW+6Dud8E
         yXecnYrNp4sjjmCQUUfMeBtverXoRrsMjqP/u++ehDhG+gbI83NSLhhWulEC+O0gbG
         DYr7potpYY+Hv+saZSPdgvrOYfZv48a03BmPocgg=
Date:   Wed, 11 Mar 2020 15:18:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, allison@lohutok.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: imx: Drop unnecessary src_base check
Message-ID: <20200311071828.GM29269@dragon>
References: <1582691666-339-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582691666-339-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:34:26PM +0800, Anson Huang wrote:
> src_base is already checked during src driver initialization, no
> need to check its availability again when using it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
