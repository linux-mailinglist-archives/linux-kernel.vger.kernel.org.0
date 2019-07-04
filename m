Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EE65F649
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfGDKFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 06:05:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40846 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfGDKFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:05:37 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so3492064iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=krsHjn9hhUUgOCG6JlKxY/1xOMPVr2m8LyxFmEgeRxM=;
        b=EsM+JT0MSnDEohwIk0zGab4nJRLUOadnVyFwZHmLMW4SjneRTyYxPtAcwrMgAxr8x7
         j+Qa+m4LhCtLVRhSY2LBCno+Ro5Nrv0qVhtNytYVyp5pAYqoXptLa+ieRzSMR+gibj0+
         CeR8Lj3YRwX6xzoc5SdSfDXOkImimH5hYulTuBIULtZJOcQm3AR//3Dx2sU5iymnQfNR
         EPr2CwTTXVAA50qMC2RMLJYaEr0udjRAHY/fQs5D6yT3pgyJncbxxg+STfrTsQG9QCDV
         YCWIfU831YRDgg+grt03ZGhYQZcjhcdFPCZ6jvGM+i0JTBHiTXf+mlB6a4Tdy9yYRJt+
         haMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=krsHjn9hhUUgOCG6JlKxY/1xOMPVr2m8LyxFmEgeRxM=;
        b=dONmt1OjfzUwPTWZGvnBELMwMFpIjdRR9Pyhi4bYC1mv+zQ0rrW2wZtvaH8hf8nLj9
         tfvCCOgDUNlxz0SmwDqOogJP/foRq29cabf4qU4mzeKLopteGwC7bjQ4tkI0hI5N5o4Y
         6kmwze0a90/KRilQfHV3UqXAxwGD/VML7PMnp6KwkjKC56P4p0yMBaiW1FJIqijSSiLU
         iaal5nXMsvV73qzUtUbzir7GLm9EQEmx8zuJFqj7YXsjYdMdovij8hjgUX4eihHjxfGh
         EwjgpO1D+cnJnTfhPgfc4kuK7qomyPK7xQMaF0H1Tz539KR1R5kOVMcMtYg9z8InFGNi
         M+vQ==
X-Gm-Message-State: APjAAAWq4mz4Z1IeSEAjEVfefKdSFx7g+VLZuGsCBEch67RiJPqj9itE
        t/T0zawaf1hGtGn74lC8keG83A==
X-Google-Smtp-Source: APXvYqy+Vw0ijCA9nUuvRgEtpZuy2PgvgfbfyYaQUmWc/vxvlVfF6B+Obh6CGc8Gifw0epaDFsRiEw==
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr3527890ion.204.1562234736616;
        Thu, 04 Jul 2019 03:05:36 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id m25sm4267985ion.35.2019.07.04.03.05.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 03:05:35 -0700 (PDT)
Date:   Thu, 4 Jul 2019 03:05:35 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Palmer Dabbelt <palmer@sifive.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Paul as a RISC-V maintainer
In-Reply-To: <20190628002753.5573-1-palmer@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1907040304580.10620@viisi.sifive.com>
References: <20190628002753.5573-1-palmer@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019, Palmer Dabbelt wrote:

> The RISC-V port has grown significantly over the past year.  Paul's been
> helping out for a while ago.  We agreed in person that he'd take over
> collecting the patches and submitting the PRs, but it looks like I
> forgot to make it official.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Thanks, queued for v5.3 through the RISC-V tree.


- Paul
