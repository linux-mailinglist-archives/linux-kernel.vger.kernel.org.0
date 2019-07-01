Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB01A898
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfEKRCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 13:02:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42018 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfEKRCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:02:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 847161478DBF3;
        Sat, 11 May 2019 10:02:34 -0700 (PDT)
Date:   Sat, 11 May 2019 10:02:34 -0700 (PDT)
Message-Id: <20190511.100234.2036927312468388445.davem@davemloft.net>
To:     hofrat@osadl.org
Cc:     aneela@codeaurora.org, gregkh@linuxfoundation.org,
        anshuman.khandual@arm.com, david@redhat.com, arnd@arndb.de,
        johannes.berg@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] net: qrtr: use protocol endiannes variable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1557536193-11949-1-git-send-email-hofrat@osadl.org>
References: <1557536193-11949-1-git-send-email-hofrat@osadl.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 11 May 2019 10:02:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Sat, 11 May 2019 02:56:33 +0200

> sparse was unable to verify endiannes correctness due to reassignment
> from le32_to_cpu to the same variable - fix this warning up by providing
> a proper __le32 type and initializing it. This is not actually fixing
> any bug - rather just addressing the sparse warning.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied.
