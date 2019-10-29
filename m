Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D85E9301
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 23:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfJ2WYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 18:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfJ2WYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:24:44 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E3B20717;
        Tue, 29 Oct 2019 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572387883;
        bh=D+kyyB7UXdE00h1hhFmw71lmhkWEAKdVovYsmlb2WwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qRZ3CPOmd40eSHqwIK8VBuAx4hiXX4EPyBgU/uTUURAPCZaYXWZCI/j3mXKKbSbzg
         RBwJKOZV21whk4IdUkTm0RZwpShqaZWp3xEMmtI2pmfB5ghWCcpzZ0Nb1MGNZLLkDy
         cSZYruN+QnJ5d7cCe7HQzU5XR3+c/cFAKicpSvXc=
Date:   Tue, 29 Oct 2019 15:24:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     cgxu519@mykernel.net, linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] hugetlbfs: fix error handling in init_hugetlbfs_fs()
Message-Id: <20191029152442.32bf51a13e48d9b2d83cd504@linux-foundation.org>
In-Reply-To: <94b6244d-2c24-e269-b12c-e3ba694b242d@oracle.com>
References: <20191017103822.8610-1-cgxu519@mykernel.net>
        <ba6cd4a4-a1cd-82c0-5ea1-5e20112f8f6b@oracle.com>
        <16e15cd0096.1068d5c9f40168.8315245997167313680@mykernel.net>
        <94b6244d-2c24-e269-b12c-e3ba694b242d@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 13:47:38 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> It is assumed that the hugetlbfs_vfsmount[] array will contain
> either a valid vfsmount pointer or NULL for each hstate after
> initialization.  Changes made while converting to use fs_context
> broke this assumption.
> 
> While fixing the hugetlbfs_vfsmount issue, it was discovered that
> init_hugetlbfs_fs never did correctly clean up when encountering
> a vfs mount error.

What were the user-visible runtime effects of this bug?

(IOW: why does it warrant the cc:stable?)
