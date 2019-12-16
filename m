Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE541203CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 12:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfLPLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 06:24:23 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49880 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfLPLYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:24:01 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id B1B1B200ACB;
        Mon, 16 Dec 2019 11:23:58 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 1316C20AD0; Mon, 16 Dec 2019 11:25:34 +0100 (CET)
Date:   Mon, 16 Dec 2019 11:25:34 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Simon Geis <simon.geis@fau.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: Re: [PATCH v3 02/10] PCMCIA/i82092: add/remove spaces to improve
 readability
Message-ID: <20191216102534.GB159459@light.dominikbrodowski.net>
References: <20191213135311.9111-1-simon.geis@fau.de>
 <20191213135311.9111-3-simon.geis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213135311.9111-3-simon.geis@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 02:53:06PM +0100, Simon Geis wrote:
> Improve the readability by adding whitespaces after commas 
> and around comparative operations. Also change indentation of 
> one comment block.
> While at it, remove trailing whitespaces and spaces before tabs.
> 
> Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
> Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
> Signed-off-by: Simon Geis <simon.geis@fau.de>

Applied, thanks.

	Dominik
