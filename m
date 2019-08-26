Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF609D603
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbfHZSwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 14:52:11 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40427 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfHZSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:52:11 -0400
Received: by mail-pl1-f202.google.com with SMTP id k7so1097154plt.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f13wn2v3HTWLW79B2qFqNfxBA9vXXjNlnyblgswdq/E=;
        b=bfmZE7Uf1xNK78UufCnnG87LZS9m7cHd1LRQUTgSX4t1YttJJSQNzi3p93vCxe06t6
         l00juMEHKARjQyGo2vyvuxvJHkds8eC5FP5YGXqW+64X4/T/kfzRqfH+u77bxE0WVg0Y
         MozDokfGxp/B7yoUO6goIxvixoWQYk6g/nYYbuEeu82L+uJnPGRT+0i28/YCQAQyXuzW
         CNSZMPeDkigzmEfwJfNqaMAbCATcFEDvzQnonAmyAstW1Jo09TS7feX8QuZ0rwtPxAWz
         Ex6y5/XLNKFp2sCQWqiT0Ain+OGSZccgXThs0vaj7qMLKj0vN9EU+Ij2d5H7GLbHGPT3
         sHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f13wn2v3HTWLW79B2qFqNfxBA9vXXjNlnyblgswdq/E=;
        b=GQ0+xiSDvVPnybM8u/cvj/Km7+24g7UsEqpf8aEP56wPrTtirxH9sKq4fwOB7iFI/4
         OKCs+FZkpJUpAtkkNW7ytHJtqklPRREhj7SF9x6q2Tp7qM4SpInHVAZ74G2SxemyBuOV
         4uE7Sb3IBr/aQoFJiF+2ulo5sLi/75/smIbG3aTtonLhWoVtd4G2yGY9Wu9lKyrgMEmm
         9qOQ3iY96W2TOkDY5ZVIgj9cA5Aghei1rshpQzH0zxA2E0JgROdkhe0s4WDloLqnQVyx
         5Zx7zbI7t1dIVLodzN1L1SrDjcJHYZfeLJv+gKA9K/wCqHdwqH/9Ehq5sewVgvWrL2N3
         SN6A==
X-Gm-Message-State: APjAAAXwynvEqRafWp9paRFc53FOhM4dXB4CUJ39a5lGSmpMUdUr/SIB
        0pfn+SN/Td5ynimJFSsesr6HU+alpQ==
X-Google-Smtp-Source: APXvYqxofBxaAILlefFytt3O0sJSZvx4y5z2QEpvVJn6P3QTOD4bxfISMK9z35l56sFzEoUKmV+9pyuRX0U=
X-Received: by 2002:a63:e213:: with SMTP id q19mr17542135pgh.180.1566845529981;
 Mon, 26 Aug 2019 11:52:09 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:52:06 -0700
In-Reply-To: <CANLsYkxC-4UZcVKoTQiJ2PsDxwuriFoAwqdbM39EC1G3nwwAHg@mail.gmail.com>
Message-Id: <20190826185206.105863-1-yabinc@google.com>
Mime-Version: 1.0
References: <CANLsYkxC-4UZcVKoTQiJ2PsDxwuriFoAwqdbM39EC1G3nwwAHg@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: Re: [PATCH 0/2] coresight: Add barrier packet when moving offset forward
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

> Can I add your Tested-by ?

Yes. I just sent a tested-by reply, but not sure if it works. I am not very familar
with linux kernel review system.
