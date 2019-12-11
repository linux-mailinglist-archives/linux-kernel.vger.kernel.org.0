Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBDC11A50A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 08:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfLKH0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 02:26:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52988 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:26:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7CDAC14EC291F;
        Tue, 10 Dec 2019 23:25:59 -0800 (PST)
Date:   Tue, 10 Dec 2019 23:25:56 -0800 (PST)
Message-Id: <20191210.232556.198185739663319799.davem@davemloft.net>
To:     rppt@kernel.org
Cc:     sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com
Subject: Re: [PATCH] sparc64: add support for folded p4d page tables
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191211062649.GA28255@rapoport-lnx>
References: <20191124085720.6201-1-rppt@kernel.org>
        <20191211062649.GA28255@rapoport-lnx>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 10 Dec 2019 23:25:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 11 Dec 2019 08:26:51 +0200

> Any updates on this?

I thought I gave my ack, sorry:

Acked-by: David S. Miller <davem@davemloft.net>
