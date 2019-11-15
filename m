Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E3EFDC8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 12:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfKOLtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 06:49:36 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43365 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:49:36 -0500
Received: by mail-qv1-f65.google.com with SMTP id cg2so3648364qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 03:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7dKMxnLIw0I5IEWPEmne+t8dS2cYDCj65egnvnRmvl0=;
        b=V5ZHn4M2I9DoDc5fquceOLxcOcsj8avK56d4Gp2M07sPKeDjIb/V/Lpy889CQQ3gVG
         XGEKNr2zF74uYcOD1oWxrMFwvdHFqskLThmRAuwnAbKcN8U/4B2xM4fdQxrUmdUbFwmj
         DtaAaBLzOa3gahF70sElv8/Qb5UWNmP/2Z1LzuSQ2kUJ4kkmyM9j8hfBm2Hkt2EE4edI
         DxUaakmSSztoxyA0mX2GVcuclU5EkUzSv3mC+B9tqp8CzHCThC1f6tGqpv0d0OjCTtTy
         j/OEtfvEXPWxITCWOAaaI0BTwLyjk1kl0E/UJmJkw5uLE7lrL4WHxbxPIzW0JHiCKROt
         ETrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7dKMxnLIw0I5IEWPEmne+t8dS2cYDCj65egnvnRmvl0=;
        b=BsAojT4V3IXaigVE8AoZucUWjQUBCskAFSoZN2YrW3hITQIKFpTb9r34zOViP4d5MZ
         uXPwS++VcIlzIlJMK8luKsD2o3zomvMicVEfCkIFUC5YlfKTMxaLoM4cfs7iTIbApjDN
         LMtnv+TFW5c5BalRIM80L64CcmVCp+mPsFmwvbV11h+DgystBHkcRA5TOBMcveDMcRmZ
         x4PMe5cG58WWSa3EdGqEkpQBk15ijVuo90hv2/maC6AETq3zdUWiLEnooMi5njGbeyxO
         fWAzT8rXxyp+Mc2ZcKyH+AGaLtW74gqYnxDFIV6yfJhMmSTcJoA7McwK5pF3HknUbMN6
         jbpg==
X-Gm-Message-State: APjAAAVVcOZgcrMPkjBZs67K/HiFVrbybjKdnGGZRcBSjwUUf5TW8iMj
        mVqGS159ePtXatsxPZCe5+YnOQ==
X-Google-Smtp-Source: APXvYqw4nEiUmME4o46iZd1sb3Igi+ECzv4G/OReLnRz7VXhpiuSXHueX0saATf7jq4PwguL+tIMGQ==
X-Received: by 2002:a05:6214:8c6:: with SMTP id da6mr7169079qvb.1.1573818574998;
        Fri, 15 Nov 2019 03:49:34 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x12sm4050375qkf.84.2019.11.15.03.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:49:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: get rid of odd jump label in find_mergeable_anon_vma
Date:   Fri, 15 Nov 2019 06:49:33 -0500
Message-Id: <A698637C-E871-4AE9-A6A4-9AFF06C48B81@lca.pw>
References: <1573799768-15650-1-git-send-email-linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        sfr@canb.auug.org.au, rppt@linux.ibm.com, jannh@google.com,
        steve.capper@arm.com, catalin.marinas@arm.com, aarcange@redhat.com,
        chenjianhong2@huawei.com, walken@google.com,
        dave.hansen@linux.intel.com, tiny.windzz@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <1573799768-15650-1-git-send-email-linmiaohe@huawei.com>
To:     linmiaohe <linmiaohe@huawei.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 15, 2019, at 1:36 AM, linmiaohe <linmiaohe@huawei.com> wrote:
>=20
> The odd jump label try_prev and none is not really need
> in func find_mergeable_anon_vma, eliminate them to
> improve readability.

Warning: subtle code don=E2=80=99t touch especially with little gains like t=
his.=
