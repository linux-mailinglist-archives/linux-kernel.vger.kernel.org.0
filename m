Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C47B315C964
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 18:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgBMR0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 12:26:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43961 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgBMR0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:26:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so3389363pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W0kPYSGZpFmUqWv9seoH6YBSbGZJRy2v/6dlw3/QF5g=;
        b=qmP5IZjP+6eO4zBDlJ/ETwfNqBc4vfDwE1hX5sbHwzSKhV01vnx+Sr3YDNpaXpfzzR
         rbM1vtUYCniaH41MN0zI3QS19GxQpuk/tQJnLV5zRzT3qA1QHqHuapuDsYq1UlKx1TyM
         Ru1DOsGha4Nz9j06vKZRnVfu0qVa+SrWMmd73XFcMUksCBU8SIdaT6tK6xtQrbwuTxor
         D5tdkJqnY7xMdybBDJt3iRJdi9MzCEQTH3zEi+LIARj/MTC8IHw0At1gr2IpFSGd/SC9
         euEhRkRy795d+HRbKHFcGNiwZ56570IcW2HKBQCpKWXiHsLNAf8KfyYt0V70TcuNV9X9
         6DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=W0kPYSGZpFmUqWv9seoH6YBSbGZJRy2v/6dlw3/QF5g=;
        b=J70JeR4U3TLYJh3EW2i1bSpU60kafq/G7c+upQnPO5fPfnVVhw0nV49Wq+V1PeqEIh
         IGHnxePwRhbsDczyAuoeiZ2f9mr04vePpP0zCbWhvXfKimBPxKSRLjanUxlYg+h7ruMJ
         6YHEcGLtBbRMsCzjb9QsjSI1Ubzqlb0r39JNFAzMMNCXKnViHgAhw+N8WBTjTZQJas2p
         Um+Sosjc93J7Py5M3i8e3/ww6o7xq2nMCdoLFwQHYzz7fXvtpYYUBSNHash80jyLeDGK
         3YnvJgmC1X6H8uvmUybzcroiXgOhFX4e/KmgLlW7eRF/3OOp8VG8ReZ0ilnIH34r8/do
         ZB2w==
X-Gm-Message-State: APjAAAVCLSxBrql7tlZXLh3Yb+qaN5ZuwhqAzvNns3eNspT5OtmlR9bW
        4LpJYZup7m4JOs6oNUkJ8Sq+iUZ9
X-Google-Smtp-Source: APXvYqwjFu0EPDvP8k9bCzLALt7wPIRCseUfwxZN4pAUYvuvclJpbDpVjfrzrqvb+1QNhQaKt9YuHA==
X-Received: by 2002:aa7:946b:: with SMTP id t11mr14598181pfq.57.1581614768327;
        Thu, 13 Feb 2020 09:26:08 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id f43sm3617357pje.23.2020.02.13.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:26:07 -0800 (PST)
Date:   Thu, 13 Feb 2020 09:26:05 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     anshuman.khandual@arm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: replace open codings to NUMA_NO_NODE
Message-ID: <20200213172605.GC41717@google.com>
References: <1581568298-45317-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581568298-45317-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 12:31:38PM +0800, Yang Shi wrote:
> The commit 98fa15f34cb3 ("mm: replace all open encodings for
> NUMA_NO_NODE") did the replacement across the kernel tree, but we got
> some more in vmscan.c since then.
> 
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks, Yang!
