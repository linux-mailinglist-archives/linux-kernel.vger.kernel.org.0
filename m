Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DBD1012AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 05:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKSE5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 23:57:16 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38028 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKSE5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:57:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id a14so17700383oid.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 20:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UvkLGHgSvEIQI2WG9EBqccOe+HOcwjAc1fTcAv9zhAk=;
        b=qTlGheLnk9j7Jtg8ORqOUUIUR9icg7OH37dIf6wW26OuEIa2BvnW7Qixap4O6khJBB
         mzeeiJv3z0sBntejsJJdYWUtaAK7gdMOZa5Fw7mLD1GDqwuNEDkuJIBP3EM/If2IVR3x
         Uh1VgCUydqjmRxpiSgvXmvLINdknZxrBD8/oFnD2kabg3bZfTcruNljyySuA4qFfaaLO
         GzQgLSwfhQbRVcNuuRy7D6AKOEmq0LFOqGDXWB1/lQROrMVdchsUy1jwDLuPhD/lHK7n
         FdMA1fJciqh+4VSgU7pdZ1yZocH5vt5WOQGvQc0s7RA9X7tU+8btrMcMDRctleGTEF+p
         4AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UvkLGHgSvEIQI2WG9EBqccOe+HOcwjAc1fTcAv9zhAk=;
        b=dCtAeneC0VNCXIhA0rWJ3jKhHPxOFtZ9pPV9NYRskMdrWEkPhsG5S1RbwApqjJ9lu9
         XW0YxaxJtfObW2f/UTqX6Nj5pkufekOwvYNIJkFQltQSAQczJknDjLuRmMe92qg/Qv32
         oQ9mLSzdq4v5oV3S8zqK2lQdZOIfMMOdx7OHFSqOW6xRYuAP0edmRVB3zWcWgpcpwvW9
         uOMUHyFW1nonzbJH91szv9pNvg5DAyhqDLtuU8SZTB4ta1Ka6JgWG/fI7qA0ZRCOLmjc
         4wzUHROyFSZ/ffySJEVSR1HncnAZ6J2x/TJNpxclP6B+PWx0hqZDzaHfjK9ZGUB8cY73
         Ia+Q==
X-Gm-Message-State: APjAAAVwbKmDubJ5jn6R6hQ7Q4caUswFtsajIBJzAkC9bZbIAO50bUaG
        OYa7rjrxSsZ59qTi19AB/fA=
X-Google-Smtp-Source: APXvYqzELbV9nrbsgdQ8mJAxGjlH53lHYWG1QkQvToy+qIRFXnecB49sDO1vLwH1WO/+7GLO/h0pow==
X-Received: by 2002:aca:4c14:: with SMTP id z20mr2385666oia.76.1574139434761;
        Mon, 18 Nov 2019 20:57:14 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::7])
        by smtp.gmail.com with ESMTPSA id e88sm7019765ote.39.2019.11.18.20.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 20:57:14 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v5 0/3] LLVM/Clang fixes for a few defconfigs
Date:   Mon, 18 Nov 2019 21:57:09 -0700
Message-Id: <20191119045712.39633-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191014025101.18567-1-natechancellor@gmail.com>
References: <20191014025101.18567-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series includes a set of fixes for LLVM/Clang when building
a few defconfigs (powernv, ppc44x, and pseries are the ones that our
CI configuration tests [1]). The first patch fixes pseries_defconfig,
which has never worked in mainline. The second and third patches fixes
issues with all of these configs due to internal changes to LLVM, which
point out issues with the kernel.

These have been broken since July/August, it would be nice to get these
reviewed and applied. Please let me know what I can do to get these
applied soon so we can stop applying them out of tree.

[1]: https://github.com/ClangBuiltLinux/continuous-integration

Previous versions:

v3: https://lore.kernel.org/lkml/20190911182049.77853-1-natechancellor@gmail.com/

v4: https://lore.kernel.org/lkml/20191014025101.18567-1-natechancellor@gmail.com/

Cheers,
Nathan


