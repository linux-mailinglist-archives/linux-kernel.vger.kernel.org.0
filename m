Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16817E5A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 18:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCIRYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 13:24:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37690 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCIRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:24:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id l20so5944432qtp.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dks3i5CkPUQ+F21OaKeehSuQxnIMN5i6J4CZW2sJwAg=;
        b=Z1I5JDhf6JPhDANs9LT2Z75zZ40ZGN96qONEEs10yb0Ydwt4AEpMbjVOaeuaW34y7k
         GqOkGV45kEzToTEqCGNkwEq1QeOqi4dDDHah5nA8iyUC2ScAqMAxnaqVdHOdMN3hZPxG
         2Qsf+M/UTcKvSIQpHYPmEus0QOM0y8nEFk8Dlm5gkRlNndfHf4+9j0vmSAS9Lu2A+2XL
         tvhnWXmeyf/OCf9e6X86IoH8nbboyUD9rOmHnXF+d4NpKsKX2A43AOMnvSj6In7BZ03g
         a1/4l1wDim/oN+5Wy9N2OFsrPVofgre+pPaJv+6WtYFsn2Qx1tXEdZAX1g0wnAK/lCmd
         zHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dks3i5CkPUQ+F21OaKeehSuQxnIMN5i6J4CZW2sJwAg=;
        b=TR38MsTAc8xT3YJAgm9I9Twzr7zAcPQkbhnwamoYiZLgMI7fl7gyeGyJATrNIm/4Of
         ES9prtPxetXyDV4JT07Ys9ap/jTPuE9XbMsU6w1jT5fxazPQ3grD6UMr6ErYlW5N+LH5
         KaNDqx1nMpE50Xc1Qwjf+7EaTFji/B+808z365BXPJ9VpffeTGjrm4tIkBtrED7DhzHP
         cACyim8/M9MRonEPjLQjWJDYLjaxAeWIgDCLDemUNIkOxFmCadVizmmJdIgsf3dHnnid
         RFHQZpvfgOy9fnMns498LC/i2JaDWvM+8EC30C92rWx9MtvK59Pr9mJPts4fDYdaT3SC
         4+NA==
X-Gm-Message-State: ANhLgQ2rQ0JLq/pKVaeq/sj++eoMeJFaO1mKlgfeuU0Ma7WuaM3VYDKJ
        1zY4rr3S9FPVfqCmsOxNuuJMYQ==
X-Google-Smtp-Source: ADFU+vupi9qtS7gHPWD88xYrZVl3D06G7ygMTFq1jcL4wqzVIfcwn3v7Dhs/5Q1X9cbt2cRgCDPPNw==
X-Received: by 2002:ac8:2bcd:: with SMTP id n13mr15638628qtn.21.1583774672271;
        Mon, 09 Mar 2020 10:24:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 65sm22838452qtf.95.2020.03.09.10.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 10:24:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBM8k-0003l3-Um; Mon, 09 Mar 2020 14:24:30 -0300
Date:   Mon, 9 Mar 2020 14:24:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+06b50ee4a9bd73e8b89f@syzkaller.appspotmail.com>
Cc:     chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: BUG: corrupted list in _cma_attach_to_dev
Message-ID: <20200309172430.GV31668@ziepe.ca>
References: <000000000000cfed90059fcfdccb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cfed90059fcfdccb@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 11:13:15AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16a8fa81e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
> dashboard link: https://syzkaller.appspot.com/bug?extid=06b50ee4a9bd73e8b89f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e804f9e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d6fd29e00000

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
