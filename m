Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017C31478D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 08:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgAXHMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 02:12:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37722 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgAXHMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:12:38 -0500
Received: from localhost (unknown [62.209.224.147])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B820F157D8A7D;
        Thu, 23 Jan 2020 23:12:36 -0800 (PST)
Date:   Fri, 24 Jan 2020 08:12:30 +0100 (CET)
Message-Id: <20200124.081230.2113337155170121177.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] caif_usb: fix spelling mistake "to" -> "too"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200123004555.2833355-1-colin.king@canonical.com>
References: <20200123004555.2833355-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 23 Jan 2020 23:12:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu, 23 Jan 2020 00:45:55 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
