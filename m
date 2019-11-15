Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD6EFE610
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 20:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKOTx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 14:53:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38592 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfKOTx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:53:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id p20so12049149qtq.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IsyLWQ2rudgA1dfvEg2LT4nZEaPujsclpElv3aF+5fs=;
        b=fb63xrBBljzgxb94F+3bo8xOvpSevc8YzKtUZuSx0V62wpC78+Ro9w8xl4n0dkcHZa
         wEcDXHOjzfa99hJ/4bvvWD12N47uqbwxGOkA5lhCq6nvlVaKYGjFsHQQUXzmNP/DoHsc
         y3wU4MbKJ31RYqGS/g4cH4tFgPaiwhyAY+DzzTlEekzmlYB9GHNyV1oxufXI2DOZX7xq
         HF+t1dG+EJHiDCtnKFLoPRVf5GIgErs2rTijse01spZwzj3PBoLSqMJDBh2lcGti9XoK
         PCemGWIq1dc2rW1K0DyVRwEHUTN/B+0rHjxIBxe7wP1xSi/0qpkpYsaPEMMUnxqiZXGO
         b6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IsyLWQ2rudgA1dfvEg2LT4nZEaPujsclpElv3aF+5fs=;
        b=mI5qCIYRacRucnBWN65vBQWXxBKvGgWsC4XwKRb1XbnZTDV4InRjg+Ww9NR2rmzL0Q
         1g9Xa8CXKxk0yFNRwhIo2KBeOhHu7OHki8KqbIhEry7xfDoiRUEk+KCXtDku82lxCuhb
         iPTZSjdX9vX1bJq/fnemch97mcb9nlB6VZ7Pm5dQa/py0M12t6GlUj8jNpOvrUG9VZGp
         z9emr40mYDQ1JYSsFlIqsBzLFr4tShKTZ4V/AQFJdYZ14LpLwwmj+Sq307FYIl2e3Iss
         kU6lHWVoLIOe9fZyi9fgJ6DkxMrMl9Tc+bCWzstC+ncwViPr66SnLID/YDuF4+NhohYR
         EWoQ==
X-Gm-Message-State: APjAAAXGXXejvHIYWzU5IdZkljJHnNwdSHiXEhZyxkizbQnWDnHd2oG1
        Y6+pVndmctphnikmxsuJjNPzvxse
X-Google-Smtp-Source: APXvYqwQMt2m4alobQ3Rl766P/h9zfpmyUnkSMt299RU1W8EsbbfpyumMS/0c/RNP8WAr3U0JhsDNA==
X-Received: by 2002:ac8:6f44:: with SMTP id n4mr15388197qtv.379.1573847637447;
        Fri, 15 Nov 2019 11:53:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::9935])
        by smtp.gmail.com with ESMTPSA id p3sm4576733qkf.107.2019.11.15.11.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 11:53:56 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:53:53 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] workqueue: Add RCU annotation for pwq list walk
Message-ID: <20191115195353.GS4163745@devbig004.ftw2.facebook.com>
References: <20191115180125.j4gvmltzi6z2szhw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115180125.j4gvmltzi6z2szhw@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 07:01:25PM +0100, Sebastian Andrzej Siewior wrote:
> An additional check has been recently added to ensure that a RCU related lock
> is held while the RCU list is iterated.
> The `pwqs' are sometimes iterated without a RCU lock but with the &wq->mutex
> acquired leading to a warning.
> 
> Teach list_for_each_entry_rcu() that the RCU usage is okay if &wq->mutex
> is acquired during the list traversal.
> 
> Fixes: 28875945ba98d ("rcu: Add support for consolidated-RCU reader checking")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to wq/for-5.5.

Thanks.

-- 
tejun
