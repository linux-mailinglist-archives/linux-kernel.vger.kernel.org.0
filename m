Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7618004
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 20:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfEHSpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 14:45:15 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:37176 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfEHSpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:45:15 -0400
Received: by mail-it1-f175.google.com with SMTP id l7so5624185ite.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qmlg0JeGofyEggaiu3SeWlwb5Kg7HnuVjkibnojDbHw=;
        b=HQb0JYl8SLGMpyPrVhtkt6ejHEkDm2VuHOXVbj5RSKe0ke6ZZ7nAAltAA4DlSKKKuX
         9qXdDby11gnRD0FR6uDYaXftX+5EMvRFwQ4DKuH5PnK79DpMTP1HJXPgtbpJ2ygnLpuW
         z2B36wvmyTQJhi59rWTuCkj/Y93yN7IMN79fYWqhfEw8mUAg58eyr1OhskcltQqBohTx
         1lpOVsC26ROZBq7yhKEkxdolpYq5XHQRn8GGOhxGUUhHLxsSQ4zp4v9HpPEQ0Yxy9KZ5
         DoPSY4AsEncoRBjVi/o8mPRLjMmmDZqvu7kUp9CWvOsx2IHGJHzBw9q+lQDQ9lRpfQWj
         ed9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qmlg0JeGofyEggaiu3SeWlwb5Kg7HnuVjkibnojDbHw=;
        b=RFjltOpcCe+NbCJ5qOFPOP5Fr5XGe1me3pBIPOPGldGWUW/YzJMrQsPuTg9wQNy8p+
         5xtKiTtRGXIT6WXdrYcjIvwSW3vc5JL25A0gTBVJPmzS7Rs+4WwubyWfZnkyMhwuco75
         cWL2hSYS1B53k0W9MMsf6H6yY+u/AnnaDXdwjKBaVUhfDk/NZ7RBAiJZkrdqCFDO7ap0
         /dzi+qIae6numUzumn3l0+IWAlKCyurXPmzdGXPL+viN6EFxuKvt+Fmdaa07D+QAKfLp
         BI8+ABxhw+sN8yrCW2w5Ksj6+1SENLti331NDTM9c03oRHe2mpHFZZHAAFz7+l08KFQW
         orlQ==
X-Gm-Message-State: APjAAAU/Uf/zIGlaUWU6cqoicYQPnqhh9bM1DUJmOK7KMdOnA5OBEsII
        uS7OdxyufgZ6uBe0lAgmOmkxuSgjkApnxo9+lW+SQrc5hUC5JQ==
X-Google-Smtp-Source: APXvYqzBtkzm0MG48FUEYxE+Opvq81KvCL8XdDjywIfWoGAUgHkORAYPGEjnEtWcjq1CrCp03iBiS7O8FJgHrN6a36U=
X-Received: by 2002:a05:6638:606:: with SMTP id g6mr29560476jar.129.1557341114367;
 Wed, 08 May 2019 11:45:14 -0700 (PDT)
MIME-Version: 1.0
From:   Salman Qazi <sqazi@google.com>
Date:   Wed, 8 May 2019 11:45:03 -0700
Message-ID: <CAKUOC8WxRnzeMEcS-vao-GOzXnF+FN+3uk8R6TspRj23V7kYJQ@mail.gmail.com>
Subject: icache_is_aliasing and big.LITTLE
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What is the intention behind icache_is_aliasing on big.LITTLE systems
where some icaches are VIPT and others are PIPT? Is it meant to be
conservative in some sense or should it be made per-CPU?

Thanks for your help,

Salman
