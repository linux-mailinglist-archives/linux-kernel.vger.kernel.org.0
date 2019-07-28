Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970AE78163
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 22:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfG1UIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 16:08:44 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:33108 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfG1UIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 16:08:44 -0400
Received: by mail-lj1-f171.google.com with SMTP id h10so56468667ljg.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 13:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8Ehe9L15ikwLaOegvSbffqJNAvcSP5VfCjBEA7JSyTc=;
        b=bfXCKeDzFYrg4MDemsuOpzg4Sp1nFZbU2vqp5UM6hom89AfV5gv0Sx7PuDAL0awUAU
         UlY5NBJ5vY15u1NWeNfkT8vuL6x9VCinedHT6rrJX+Lqt9kN5OnIv9+da1v9uy4dKrlE
         Pg2mNUtyskepb6coBNiRDn8k07M5Kc0jXpk3uycVKZeIIs5RSftlMKjoM5i5WXfWy1gY
         E0FCRpjqA3wVPADGAwTfH8mJaRAQFYLMtC1Mm/W6eCtyPJFRo1/RAYAaug7JhRW/PHGZ
         NLo8b/Z4cRhM4UH4y9jXc++1YfhZ0nMPYgICeEUQGriNnevFAZ5ewMR43TyY5dw599Jj
         MM1Q==
X-Gm-Message-State: APjAAAWv958lrScpp+8wmsYNGFwswvYPGaltr676KOysWtJuAwbVrsb3
        l7rPVlrzYEr5a6oIWJ+XAhro23j8JoQ1e1aytOOCZBmk5AI=
X-Google-Smtp-Source: APXvYqzMDT7jLYyQwW9rgotscZ5/OzUxcCpfRFZVxxEtiiDmgFqSMegnW8RjxzWH+5JfETP9r/+o5SYBwlzM8A7wA8U=
X-Received: by 2002:a2e:9643:: with SMTP id z3mr56707238ljh.43.1564344522278;
 Sun, 28 Jul 2019 13:08:42 -0700 (PDT)
MIME-Version: 1.0
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sun, 28 Jul 2019 22:08:06 +0200
Message-ID: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
Subject: build error
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this build error with 5.3-rc2"

# make
arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.  Stop.

I didn't bisect the tree, but I guess that this kconfig can be related

# grep CROSS_COMPILE_COMPAT .config
CONFIG_CROSS_COMPILE_COMPAT_VDSO=""

Does someone have any idea? Am I missing something?

Thanks,
-- 
Matteo Croce
per aspera ad upstream
