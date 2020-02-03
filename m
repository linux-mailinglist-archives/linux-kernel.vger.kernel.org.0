Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B641512E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 00:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBCXTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 18:19:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36126 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCXTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:19:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id j20so6912820otq.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZG+WtSGQs6QhG818eTrKWkOuEkoqiXKe+iz1pu4uMw=;
        b=kiJFgYh6yNJ0L2ecPXo+0jXN+6U8xrb9JtkyYqy3sE8LUhPMl5p9RBaffqUCdGGebE
         LV+1NURfNHCoklIRGG5UNpDL9JKrjRsBcDgdIU3Iy/5OBH0RAIagWOKEuawsfHnf+6Mn
         s/jyyzcRMDOKwGgOLBGycQM/xhhQapE69IRjL5t9dVaxVA4H4X/DSJWWMUV00IWeo6/n
         UmoAq69ILXgEvKgYpWH2xqUdIJkUvgeG30WzbMVUAt5FG9mvhFfM9KfAG1lmqVurAUfI
         lW5YiBxG4Bah8vesGavRLFwf9pBAk2vCpClJHZs2LMQlSNGHpYa9ZepQ1UvIUxR/Yxsz
         lNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZG+WtSGQs6QhG818eTrKWkOuEkoqiXKe+iz1pu4uMw=;
        b=TN+mropuGksZvSIY6D0uaHhp8Zy27PtWg1IVrm3es5wfrkdIG4HNlZGzPzMkiG6sH0
         2dunxvUeX+eptpEuLb6Ydque3oVikr+Uv4+QyVzQ0MBMj8iMzBkeSyByE81zfnB8NPwz
         Of4SkmfgRz4IBmBNTegOr1vm9KAldoT3aIrBoiI7l2zj2jXx8ZfkyCINYMYnHliSNfyL
         Ps/ruz1lpJ3DxhOnuIgTu/U0jzTeXXML3UtLJ/YBtWEvWnOArxQvtVC0PAzmkoZ/0P83
         bdDMKYL9sSyKGezMaIvquhJIi3p+WSv6TjuALMuEdFswL+vhhdboG3CyuhOSqcIQTPSa
         gZgg==
X-Gm-Message-State: APjAAAXXV+avyS9abflULdjIkUcgouTL1r7ECnqpQw2RT3Hxi5oCstHT
        hdhiGYiDJl3RLIUbCSHXoxjyrL0MSm2IQaVlnfa7Kw==
X-Google-Smtp-Source: APXvYqwaAdLyjwn98pa+6a96VcAqNjbWTndQSAHzQhZDsrfJdeG21nIO+WKsmdVQsFSjR17QNJNgzKBxSy1spQxw+A4=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr20463716ota.127.1580771945917;
 Mon, 03 Feb 2020 15:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-7-almasrymina@google.com> <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
 <alpine.DEB.2.21.2001291257510.175731@chino.kir.corp.google.com> <98c83a41-b864-5950-488c-443f6ef60b91@linux.ibm.com>
In-Reply-To: <98c83a41-b864-5950-488c-443f6ef60b91@linux.ibm.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 3 Feb 2020 15:18:55 -0800
Message-ID: <CAHS8izOh5nbTbv3+UxdLH-LHD-RKNEHoCzHCExggTbvgta-itg@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:11 PM Sandipan Das <sandipan@linux.ibm.com> wrote:
>
> Hi David,
>
> On 30/01/20 2:30 am, David Rientjes wrote:
> > On Thu, 23 Jan 2020, Sandipan Das wrote:
> >
> >> For powerpc64, either 16MB/16GB or 2MB/1GB huge pages are supported depending
> >> on the MMU type (Hash or Radix). I was just running these tests on a powerpc64
> >> system with Hash MMU and ran into problems because the tests assume that the
> >> hugepage size is always 2MB. Can you determine the huge page size at runtime?
> >>
> >
> > I assume this is only testing failures of the tools/testing/selftests
> > additions that hardcode 2MB paths and not a kernel problem?  In other
> > words, you can still boot, reserve, alloc, and free hugetlb pages on ppc
> > after this patchset without using the selftests?
> >
>
> Yes, its just the hardcoded paths. I didn't run into any kernel problems.
>

Sandipan, I updated the tests to not assume 2MB page size, but I'm
having trouble getting a setup with a non-2MB default size to test
with. I'm uploading v11 of the series shortly, please let me know if
the problem persists.

> - Sandipan
>
