Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D34F1DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 19:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfKFSro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 13:47:44 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:34013 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfKFSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:47:44 -0500
Received: by mail-yb1-f201.google.com with SMTP id x191so9054620ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iuhKlytJBZM6z4JfLv4nGpswwtwyGQLqGn2PJIaoWCM=;
        b=an/QfeoCwD2+tFI6iqjZzV7+UGnY37JqBMJqrr0vygODNoAZFN8hY3gGzThuYrNro4
         r1vixHZyW4gKDC0lQB1etIs2JcMDTaRIRi6Ha49VBCRzsmZu09UBiBH789KlJV+UVq4E
         5Q9tTdnJOJz16j3gl3npT6ro1ko/QmhobuY3fPeffAH4xEMrYEWo8ruhSqpMriM66EPs
         lDGDloiBd546bql5UixXyvn8rMEhqh1LvR6qvJmiJPq8mm6qRQhd+cyYK1wAjbIjc9eN
         LTru6pLONi219DtbPwP4dlBfQsfg4II//sMTFQG/EiPH9Zi9wYi48hsiLY3Ui5fPAfvO
         p4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iuhKlytJBZM6z4JfLv4nGpswwtwyGQLqGn2PJIaoWCM=;
        b=nXP+WEC9wuPUgMxLwa9lC1QNAw940PPdLF+EfJ5Iu1ZbdjAzB+5WFj/G7ZSPqn8PEr
         zt3ZnZktyyaSWvWMsHJ+AzjO2a/yDEKc7UdbWDG/6C6xq3L6mSDhkQJyJnNePvPn3osd
         SrTZfZha20zJhC1znRugDJOrKn4+1xDmrn/cmbqdGeCgtELfGY/dbNPlnSO47ko+zCQS
         YZ2aR9KH1z524d9nzUC1RoYGmzDYYYmsJRynUhHpRcTa3DxCWw8m3vyu+dZOXvjs7gyO
         NDiY0H6240X0MKBDM/33adhggnkElnp8XQtEz0lddrrgOms0xQNaUtNnJ0TiIPoEbNn+
         GWpg==
X-Gm-Message-State: APjAAAWbGnhFt2Hp8u0SwmeXnO5eIiBRfYypOU1oL9BCEkQfiF+2MtDB
        Hz3PqHJvoZ3HjhpvKr5qjzx47NvleA==
X-Google-Smtp-Source: APXvYqyBRZvedRyg+ZlKZ/6ICI2pXNHbDWSG6ZQeXweM7qES38VeJjyjQdoRw+EcD4m63xepknj4SpOjNJ0=
X-Received: by 2002:a25:cf55:: with SMTP id f82mr3560949ybg.203.1573066063184;
 Wed, 06 Nov 2019 10:47:43 -0800 (PST)
Date:   Wed,  6 Nov 2019 10:47:36 -0800
In-Reply-To: <20191106120021.115200-1-weiyongjun1@huawei.com>
Message-Id: <20191106184736.197733-1-yabinc@google.com>
Mime-Version: 1.0
References: <20191106120021.115200-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: Re: [PATCH -next] coresight: funnel: Fix missing spin_lock_init()
From:   Yabin Cui <yabinc@google.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fix! I should have tested with CONFIG_DEBUG_SPINLOCK.

Tested-by: Yabin Cui <yabinc@google.com>
