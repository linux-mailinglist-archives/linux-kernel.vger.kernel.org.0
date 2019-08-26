Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A76A9D4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 19:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbfHZRYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 13:24:31 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36099 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732246AbfHZRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:24:30 -0400
Received: by mail-pf1-f201.google.com with SMTP id p16so12650739pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nz19iB6O7MD55VWpcgtLqqSkXdFYuq6nGyq7F/0WrIk=;
        b=EWmh8RR8TDwyvtQH6+KLLSHkQrRuB4UlNmweuso9obCiyoej1nB4CsoTQ8ADQqL1HV
         qdai+6aGzNpS9cEcAn0Uub4Cm66DhYjBLbVpECqAQqp8NFpEbu8CLmRPu7jdg23OnNpR
         b3qmaoeJu5+h1qEUw6FtZVzM/RSkiE330HFPTmfS8lqY0v5hhJaDPn4oE1XztD2LrKM8
         BoLqBLgbU085dcK12Ao85oVrKw/PRiWJhPFLY+E0PyF2VNIbdjh9jPXFl23FS48BY1wN
         kw4tJtfhSpohqWhXMzZb5rABj6FxCLHtC+MrmCg8QqI1UCuf/tUen0Hmg1Gr7+JaWFyq
         UjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nz19iB6O7MD55VWpcgtLqqSkXdFYuq6nGyq7F/0WrIk=;
        b=SITSCV4vE2II9z3AuDUqgSiAxAIp32U5wKBE3ozeCjN/iMP/czacyd2bPaKK7LvUJ6
         A88ZJ9lZn/ra1aYnldKp3Q/qOmLjcz04JIIdeklUt96jmKafJgmYoHErg2Q8CTjqi8U0
         aXgbhu65qkDTKPyk7qdPf+HH2RT2d2u+MR1lrPunjYS/qdeQ4+LLs2sEN+5lrTLxGMP9
         ru6a5TmLQ6sGNsvT18lrBcnkYZkjqP2g+zCrjQowH3xQd15aOWMMMzkJma5afZazKGkZ
         xcrN8hVhmbm0p2kxAPPkOWyQWW5/yef5Mh1RCQSDc6cYp97bCN23BR0oOFyuWKvbbUpL
         fcFQ==
X-Gm-Message-State: APjAAAXNXSr15XphXq8q0gm9bJ9PnCgGWUxKXMgmt/Y9MytSW9c4O8w+
        KvpELakcRpBvmuF6uC7Ii7Ffo0WjjQ==
X-Google-Smtp-Source: APXvYqz3hJNx1G6AXJVADXu73yv3MG81S0NwoASrbtOhTIu6INd15Z5sFydiOV6AWzxHYwDjNMk27EcZ/Tc=
X-Received: by 2002:a63:9e54:: with SMTP id r20mr2511425pgo.64.1566840268953;
 Mon, 26 Aug 2019 10:24:28 -0700 (PDT)
Date:   Mon, 26 Aug 2019 10:24:24 -0700
In-Reply-To: <20190822220915.8876-3-mathieu.poirier@linaro.org>
Message-Id: <20190826172424.61777-1-yabinc@google.com>
Mime-Version: 1.0
References: <20190822220915.8876-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: Re: [PATCH 2/2] coresight: Add barrier packet when moving offset forward
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>, leo.yan@linaro.org
Cc:     mike.leach@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Yabin Cui <yabinc@google.com>
