Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9273947D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 10:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfFQIvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 04:51:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36732 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfFQIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:51:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so5427741pgi.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=+s0hvx2ZoDdfV9Um7bwyvmqpYaZupeqRGDBP/P7uEqg=;
        b=OiX6cA+Hu3qeu3+KIo7CeyjC7JR3UwFUkyTATiVz4UmWKl6C63xQpHeWH979BnZHm+
         mgJ+4s1Y5Yv+X5c6unYaHlZ3j6sdioCOzftaai399R1q8HHmcrEZo5QzLFEDtbAZX9b1
         9bycHAoyiG6RVJu6IppS9DDiFTgEt1hl/t9KZupMtYkOD07aNyPIyocDd2QLhiAD0XiJ
         4E3TMx3k16+rsIFw2YbiTF7Yu17TxIXReLLjQvwEJIsSmnCv4IKyur8w1azrbgwbQ2ei
         pvkQJiWPDIVWoVSNO4gchOdVVxHKzzpBjc3jpJLgAvP56gAGE0GrXyA2FOhieGaUcdzE
         QEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=+s0hvx2ZoDdfV9Um7bwyvmqpYaZupeqRGDBP/P7uEqg=;
        b=MqZlt7jA4PmT5ypDxLW8Z2cT8PrXHPHNIifPYYiY1Q1gclbuN18KpPOlNxCc9lxWvy
         i59ra96v99Rl+9mv24I/M/BhY9p3lRnSd0yQ7dcJVgO6iF8OrVRnNDvWAP9l3IavPkAc
         I4BwTj0M0Q8F0c0VT1j9UDYmSvKrEgmYDu4+7V4RCBFQm5m/yOnx0R51idX1K3SzbMtw
         c25C21fbf919gdik8NYCK+DOMESEj4vUHNoMHOyRv/KpcPTaKi+13HYe3IBTVSZvtO7G
         xvJw8yNcGALtAvmvJy49pmQ4pb2i4Y3VGhL8venZo/aWyal0jetvuSSu3T5cK40AfJQS
         g09g==
X-Gm-Message-State: APjAAAUJgZ26D1aTf11pNYZo6CRBLkZt+jt7Oew2poRYUgdaQsx9ksf3
        DX7JH0JAuY24dx7upRFHzQ==
X-Google-Smtp-Source: APXvYqxAEo7y/HvMWEyG3WkPe8qZn830M+JpmLvFyOCawIbIq2ysBhAs2UlmtTxoi2lAcl1KpmvryQ==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr45933531pgm.97.1560761481426;
        Mon, 17 Jun 2019 01:51:21 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id d4sm9443514pju.19.2019.06.17.01.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 01:51:20 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v3 0/2] fix return value issue of soft offlining hugepages
Date:   Mon, 17 Jun 2019 17:51:14 +0900
Message-Id: <1560761476-4651-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is v3 of the fix of return value issue of hugepage soft-offlining
(v2: https://lkml.org/lkml/2019/6/10/156).
Straightforwardly applied feedbacks on v2.

Thanks,
Naoya Horiguchi
