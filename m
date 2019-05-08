Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01585182CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 01:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfEHX6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 19:58:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54080 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfEHX6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 19:58:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6F6B714789FE9;
        Wed,  8 May 2019 16:58:01 -0700 (PDT)
Date:   Wed, 08 May 2019 16:58:00 -0700 (PDT)
Message-Id: <20190508.165800.635162508380574592.davem@davemloft.net>
To:     jagdsh.linux@gmail.com
Cc:     paul.burton@mips.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:sparc:kernel/uprobes.c : Remove duplicate header
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1553722125-38957-1-git-send-email-jagdsh.linux@gmail.com>
References: <1553722125-38957-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 May 2019 16:58:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jagdsh.linux@gmail.com
Date: Thu, 28 Mar 2019 02:58:45 +0530

> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> 
> Remove duplicate header which is included twice.
> 
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Applied.
