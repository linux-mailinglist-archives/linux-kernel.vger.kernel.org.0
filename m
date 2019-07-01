Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA235583
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 05:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFEDGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 23:06:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56314 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfFEDGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 23:06:08 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1450A150477E2;
        Tue,  4 Jun 2019 20:06:08 -0700 (PDT)
Date:   Tue, 04 Jun 2019 20:06:07 -0700 (PDT)
Message-Id: <20190604.200607.239727257233292079.davem@davemloft.net>
To:     doshir@vmware.com
Cc:     netdev@vger.kernel.org, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vmxnet3: turn off lro when rxcsum is disabled
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190604065838.22243-1-doshir@vmware.com>
References: <20190604065838.22243-1-doshir@vmware.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 04 Jun 2019 20:06:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronak Doshi <doshir@vmware.com>
Date: Mon, 3 Jun 2019 23:58:38 -0700

> Currently, when rx csum is disabled, vmxnet3 driver does not turn
> off lro, which can cause performance issues if user does not turn off
> lro explicitly. This patch adds fix_features support which is used to
> turn off LRO whenever RXCSUM is disabled.
> 
> Signed-off-by: Ronak Doshi <doshir@vmware.com>
> Acked-by: Rishi Mehta <rmehta@vmware.com>

Applied.
