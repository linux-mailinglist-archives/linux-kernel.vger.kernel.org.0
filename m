Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF17D42E62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFLSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 14:13:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39466 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFLSNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:13:13 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A03B91528381F;
        Wed, 12 Jun 2019 11:13:12 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:13:12 -0700 (PDT)
Message-Id: <20190612.111312.2259455687333205958.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net 0/2] net: mvpp2: prs: Fixes for VID filtering
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190611095143.2810-1-maxime.chevallier@bootlin.com>
References: <20190611095143.2810-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Jun 2019 11:13:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Tue, 11 Jun 2019 11:51:41 +0200

> This series fixes some issues with VID filtering offload, mainly due to
> the wrong ranges being used in the TCAM header parser.
> 
> The first patch fixes a bug where removing a VLAN from a port's
> whitelist would also remove it from other port's, if they are on the
> same PPv2 instance.
> 
> The second patch makes so that we don't invalidate the wrong TCAM
> entries when clearing the whole whitelist.

Series applied.
