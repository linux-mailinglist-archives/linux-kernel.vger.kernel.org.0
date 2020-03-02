Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCE1751C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 03:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCBC26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 21:28:58 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:45460 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgCBC26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 21:28:58 -0500
Received: by mail-io1-f47.google.com with SMTP id w9so9801102iob.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 18:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0980YMlHpI5mQNZ0x9GeM8jDUtERfj40WG6yxOZ0aY=;
        b=ZVPuK9Cy6YB7vebkLEbrOwTXVyBu8gFrwE59AamU37CWWkff8x7Nz9OrLpABRZvRNu
         Pb3hTyOmquoMqg6fYDpLXzZKIS18EIsVBNlw4w7e1jVMxzPPHxUUx5BY/tB1haEkdx5A
         C9Lyn+MwiksraxbOYHCeQVmEzRn0gHrj8/KYmTGgZwh21HwBhvOqvmvRp4tpJcZ1CLtt
         3Jie6KMQMVIHJ5Y3QRs3VB5kSNfEx35KSrmecdXlsjQYt8MIBcn162INGDu613w1S4Yg
         CCN3yakBD1jF+fjRyKiMsxr3FPLX0jVTkVX1SDFTbag3JMWExvs4Yegfsb3az/rs58JF
         u+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0980YMlHpI5mQNZ0x9GeM8jDUtERfj40WG6yxOZ0aY=;
        b=FAsw66oaOUgzf41ux0vuCml729DBxZ+gamLjv6RfABvD/d3eOvUYPFC5rpqHisyo9s
         AdsmSbaPG+ZULLcj6WiJ/S76bkD63rcUbnyO5ePaacYBedbGRwC54DlDtyVYQxM8ejox
         EKysYHzQ6AuaN7ithx7CF9tTHiY0sKPtEMENEtmcCDjgRBM7Z78cGnQo7bBysS9QJRvi
         BVb3wUonAyyhb8Hocz2thgGx5gWTmeLU5sKOlJ+RO4y31XaBjQq/3+FglF4x9QRbDlQu
         7QFhb2KhuuW1du6W3TkJmpaSvcNRbEVceVJGdSUuqAuAjn+BYLnxcz5PykEpD4orsjTA
         G5hA==
X-Gm-Message-State: APjAAAXx2FqJnlyTLR4qlnhVvGKtPoVgT2QjTBlOUMF/MF8coRewJoYq
        I+LKIAqW2g6C29aJlmlJngMQ9k/2h7NlRCjBfw==
X-Google-Smtp-Source: APXvYqwsPpzc21trMG0QKeGzBsTS1cZD0vaNdLT/wd0/aNF6rYH9AQ2YuIQHTk97BmbShE1c237Q2qHWcKrh6dppAAY=
X-Received: by 2002:a6b:3103:: with SMTP id j3mr9726379ioa.39.1583116137647;
 Sun, 01 Mar 2020 18:28:57 -0800 (PST)
MIME-Version: 1.0
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
 <1582889550-9101-3-git-send-email-kernelfans@gmail.com> <20200228223446.GA4658@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200228223446.GA4658@iweiny-DESK2.sc.intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 2 Mar 2020 10:28:45 +0800
Message-ID: <CAFgQCTuK5nTrm_ijohhCJyvUmiVXueGrxbqqM381ViZyx0_MxA@mail.gmail.com>
Subject: Re: [PATCHv5 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 6:34 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Feb 28, 2020 at 07:32:29PM +0800, Pingfan Liu wrote:
> > FOLL_LONGTERM suggests a pin which is going to be given to hardware and
> > can't move. It would truncate CMA permanently and should be excluded.
>
> I don't understand what is 'truncated' here?
a pinned page will truncate a continuous area, and prevent CMA to
reclaim the continuous area.
>
> I generally agree with Jason that this is going to be confusing to the user.
Please see the reply in anothe mail.

Thanks,
Pingfan
[...]
