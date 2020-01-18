Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF47D14171F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 12:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgARLEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 06:04:33 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:34021 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgARLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 06:04:33 -0500
Received: by mail-qt1-f181.google.com with SMTP id 5so23906045qtz.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 03:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=E4iQ7ZDNrYmzMAHeHyv3uP9yYvMQ0RsRxXZm7yOz4Cw=;
        b=d6JswzAOQih42l4rSMXXRRxslli+9tAZ/CG+plabBLqdTSTWpFBbQizjSQQe4noFz1
         tLH3kXqsk7JXLwVYkgIbcAYkzZPLvo+3GzHkdFWRxbxs4SHSXPFWRYV8PN+v5U/QF862
         +4z2SbeMzP+bMGu0r5e9ESL6Opxfz9zM1DdG4/fLypExnvDh4NH+yrulsdeSXTDRJMdm
         7l7S2Aed8YKQOYf/2p8Ie1XePlMIlAeUk4AFuCL8dFkqncje3hgSExF5CBpJ8nNtRxzN
         WU6m8X59fZF6KzQm5Qo2mgVv3ZuPzovylKxL+j9aL8qHGcePTraVIwLOJfUSYVa4VUdR
         5iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=E4iQ7ZDNrYmzMAHeHyv3uP9yYvMQ0RsRxXZm7yOz4Cw=;
        b=bToQlfDJE50lqDIqIj/xIuHrUK01L1eaNVBgIwd8fiIszAcefC3HlNfRp3bcsOqE9v
         8wtADVrSktuLl0VAnvCi1KCSABk2beaXWJIBhL0NITolwly45TMXZYnlNhVbUbCgpFx6
         AjRATh7GDUB1pBGKUxmar0eZ9aNwosWSIyHtR+lD0Jpmyo6l2ZC3UjYIFgJadYjpc96c
         bfvBRYTeNsc+2hofnG9eAIWEzVUZuERLMZ3wNgNJey/lhCPGpbbQxb00+Vi1Qq/Xxi0h
         UzgJcRnveoRauqQWQD/pPcd79/QXg+Ygj78NgPGR2a8UhRVoEeseQHt57ziEMkzLt4BN
         JI6Q==
X-Gm-Message-State: APjAAAV0oy2GLSyur8E/1xaeJ9IekGQQVbnAINd07LUEdIzYF67DO67F
        SwT5Iw03i9qRrbIXqe1k2vlFsA==
X-Google-Smtp-Source: APXvYqy0OAWkYxzJHelL7Pu/x/AtY+S1tuMmr4j+WEKJuL9ETD+TUIV95vcmX0JuBSca4Fp5eXLxSQ==
X-Received: by 2002:ac8:7a70:: with SMTP id w16mr11517454qtt.154.1579345471965;
        Sat, 18 Jan 2020 03:04:31 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s1sm12892978qkm.84.2020.01.18.03.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 03:04:31 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
Date:   Sat, 18 Jan 2020 06:04:30 -0500
Message-Id: <934E6F23-96FE-4C59-9387-9ABA2959DBBB@lca.pw>
References: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 18, 2020, at 3:00 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> Can't we just use READ_ONCE_NOCHECK() instead?

My understanding is that KASAN actually want to make sure there is a no dere=
ference of user memory because it has security implications. Does that make n=
o sense here?=
