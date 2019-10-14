Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BAFD59A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 04:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfJNCvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 22:51:22 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:37087 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfJNCvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 22:51:21 -0400
Received: by mail-oi1-f173.google.com with SMTP id i16so12574721oie.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 19:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OqhQeSDaocWWcugyUoJesGShn68jf9JC9j/MN8cXVt0=;
        b=nlO+lnqnRRJzINk7eKGzEsDVXRZKpRSDO9Hw8IOhKcAQWKb+dFKNUYDEXriwt3z4Vu
         r+BclH3Hc8umblXdehMtmxJsdedztKAG5pG5XV1Ec55lq52KZORXcDxvHUxm0ND9LFnr
         3GE7z2smPWBODGpLEM6FFlNq1c/2MKGrllXL2lgkxE9p7Mfx3t3VofJHUMAd4sUfPdce
         ng84xxa7grVNrKJ3FKTjyB8RFZFP3hqLg1ykKT4e3zFelu9AbVk6196besuw0r66IbFH
         8MP2+EOfKnTn2Xq7K6jsXZF3l905QzZXAhd25u1hzvr2MEjfPd0DeDodB5NZVaLGQgHr
         1u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqhQeSDaocWWcugyUoJesGShn68jf9JC9j/MN8cXVt0=;
        b=qCTPh5a7QfhPd3RYk51tqrqp8+ekTci79BIrw64OkZdASyVh8euoHn0CN5Ei/yst1+
         2V3dyEN91QMXUgaVWZVIQlsiie8VXiVU/j5fIhVimaWD7d1IE3mZQNVlse1n7LpSct4/
         ZwlTb0qywstesuFfe1OgghLbUbZmlPlBoq4OreHCldsi1xmkWavX5M/YW5obln47Em8w
         hG3w14V3gQ+qB0/GkWYpGG9y7EufMh8Hr+xbbRIAEt5Rw3/uunEFF8StwWMBIuJi4mVJ
         PqVR+xQdHz/4PjLW4f6HarSWfh9Kv3tI7HXU6+pEPl63X8w0QQgNi1Xv/sG+M4Uj9lOp
         FCLw==
X-Gm-Message-State: APjAAAVSNTBtnmtxtzBxaSeoClvlR2oOz2GaqPCaQO9frg6WqZ1OnuPz
        TFV5/KZTrvcafsYB+YncfrQ=
X-Google-Smtp-Source: APXvYqz6GBZsxgq+giKH9Jhhxhcf62juaeQg2FtUlBjagl8SKfDNfbLYziCdQj01o/ohEIMWPEkiPQ==
X-Received: by 2002:aca:cd0c:: with SMTP id d12mr22781772oig.25.1571021480513;
        Sun, 13 Oct 2019 19:51:20 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 11sm5612491otg.62.2019.10.13.19.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 19:51:19 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v4 0/3] LLVM/Clang fixes for pseries_defconfig
Date:   Sun, 13 Oct 2019 19:50:58 -0700
Message-Id: <20191014025101.18567-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911182049.77853-1-natechancellor@gmail.com>
References: <20190911182049.77853-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series includes a set of fixes for LLVM/Clang when building
pseries_defconfig. These have been floating around as standalone
patches so I decided to gather them up as a series so it was easier
to review/apply them.

This has been broken for a bit now, it would be nice to get these
reviewed and applied. Please let me know if I need to do anything
to move these along.

Previous versions:

https://lore.kernel.org/lkml/20190911182049.77853-1-natechancellor@gmail.com/

Cheers,
Nathan


