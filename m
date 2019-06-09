Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816B63A685
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfFIOuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 10:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfFIOuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 10:50:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B017820684;
        Sun,  9 Jun 2019 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560091804;
        bh=hGl7xz2P5Qx18s3E5Uq3MjSkKhmAwEH4t3jJGsTUYmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeH7+uF++dgCQwnfpCs6jfddzA8IG/dUU1Va9U+G0E+IS1aLaqShE9wRxpZPc2tmw
         SHbzds0P7ql8331Wcu9OaSgosMn8vJu0VvGyO/UTYtqcg+99zV7r9AcisBv/9/dzVY
         XSF9/OSOdaGHSsMV1R3cOsxD7lX4lgHqtMtWRg94=
Date:   Sun, 9 Jun 2019 16:50:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Nadav Amit <namit@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [bug report][stable] kernel tried to execute NX-protected page -
 exploit attempt? (uid: 0)
Message-ID: <20190609145001.GA26365@kroah.com>
References: <5817eaac-29cc-6331-af3b-b9d85a7c1cd7@linux.alibaba.com>
 <bde5bf17-35d2-45d8-1d1d-59d0f027b9c0@linux.alibaba.com>
 <D0F0870A-B396-4390-B5F1-164B68E13C73@vmware.com>
 <c2411bbb-d0e7-59b2-3418-63650b354544@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2411bbb-d0e7-59b2-3418-63650b354544@linux.alibaba.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 09:10:45PM +0800, Joseph Qi wrote:
> Hi Nadav,
> Thanks for the comments.
> I'll test the 3 patches in the mentioned thread.

This should all be fixed in the latest release that happened today.  If
not, please let us know.

thanks,

greg k-h
