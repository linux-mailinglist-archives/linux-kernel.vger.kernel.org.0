Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5EDD9C66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 23:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbfJPVUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 17:20:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54612 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfJPVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:20:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 41E8F144A067F;
        Wed, 16 Oct 2019 14:20:47 -0700 (PDT)
Date:   Wed, 16 Oct 2019 14:20:44 -0700 (PDT)
Message-Id: <20191016.142044.1532379900574948137.davem@davemloft.net>
To:     ztuowen@gmail.com
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, mcgrof@kernel.org, lkp@intel.com
Subject: Re: [PATCH v5 1/4] sparc64: implement ioremap_uc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191016210629.1005086-2-ztuowen@gmail.com>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
        <20191016210629.1005086-2-ztuowen@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 Oct 2019 14:20:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tuowen Zhao <ztuowen@gmail.com>
Date: Wed, 16 Oct 2019 15:06:27 -0600

> On sparc64, the whole physical IO address space is accessible using
> physically addressed loads and stores. *_uc does nothing like the
> others.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
