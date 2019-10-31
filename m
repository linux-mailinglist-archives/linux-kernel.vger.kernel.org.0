Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95284EA866
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 01:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfJaA6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 20:58:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49076 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfJaA6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:58:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E2B4714E316E0;
        Wed, 30 Oct 2019 17:58:37 -0700 (PDT)
Date:   Wed, 30 Oct 2019 17:58:37 -0700 (PDT)
Message-Id: <20191030.175837.1299236893426693343.davem@davemloft.net>
To:     christophe.jaillet@wanadoo.fr
Cc:     navid.emamdoost@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: Simplify 'qrtr_tun_release()'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191030063640.25794-1-christophe.jaillet@wanadoo.fr>
References: <20191030063640.25794-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 30 Oct 2019 17:58:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 30 Oct 2019 07:36:40 +0100

> Use 'skb_queue_purge()' instead of re-implementing it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.
