Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 674811802F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCJQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 12:16:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38762 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:16:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id n2so2048718wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TOyN3DpjpjdqjcLbiMAnKwTsWk7DV8pbypwAw912qWU=;
        b=YRicU/hFhvgjx4/H+xALgyv1BiQqaoAGumgv5LkN3K7U7ZrE+W1tTA/pEbzy2Nkm2F
         7EM1sZ8RugzKWOEcGUiSwTgHV3Gm0BZBoKGub14GoZwVLm4c/eVpe8dGYV8+BiBWg47i
         mSrTxrOMiP92ENa5toWN9GDZxxnQ0qU7YlaGh0KuftB6hA1THpIUJQC1uhlDOLyn9lwE
         8em8WDCSFiOzDLylQNJwGSz07JtON8ER4gI6tuZcxtKUeLPzgs3cAXnsZQPpHtwueNro
         9hlw2jWhBAS0NRIavj4heYiTWXGKi9JaXr0gQaF1siRNz0g7juD/ps4h7I0iort/jBCW
         eAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TOyN3DpjpjdqjcLbiMAnKwTsWk7DV8pbypwAw912qWU=;
        b=oiaOPyZ84kPIgPuP1FNorpCzVpMFqb9ysQc5SsyoyQpRoPiDHE6Aoc5v42nFutEBHj
         SKo7unHsrlXhjdmUemSs2sMeB/qGkd5NGt9Qg7ItvhOuOPuV0KqSlnsXQQDf5NtCq9rJ
         wEynC/qEXRDymjdoKwS+kcvK6veY5UMj/34Y1g7Ly3LuF2XcofVEXNLzEUPGcltY80ve
         ZfZ6d2FUkjzhPq/DXDhkhzSZr0Pl4bCQLTz1DoC2G1BsNOdQ38pzuNXXeEHPJT9pysVh
         LenGuGf5X5a/6YMoeRs4BIkiAxWc1Dia0Ik9uOYlzUQxcOVNVnRDs41IBC28t0WlS/F9
         6jLw==
X-Gm-Message-State: ANhLgQ0Um1wMa/+Ckvd0THOsYgzdDFbVuIZZg/bdKjMOmM9ZdBOQ5F0Z
        NwlCPSNmH35U1+rKmMXdVNKNZUgDsff0ew==
X-Google-Smtp-Source: ADFU+vtWKKuLRq5JsTx5RPF3ZovvjzbtLnQTd10eLK2nQL5Gxs19maCDAXP7dbW3tSgXAmTdVK123A==
X-Received: by 2002:a1c:3884:: with SMTP id f126mr2835336wma.26.1583856965719;
        Tue, 10 Mar 2020 09:16:05 -0700 (PDT)
Received: from gmail.com ([134.122.68.58])
        by smtp.gmail.com with ESMTPSA id k5sm2318850wmj.18.2020.03.10.09.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 09:16:04 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:15:56 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for v5.6-rc6
Message-ID: <20200310161556.GA17087@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another round after a while for .clang-format.

Cheers,
Miguel

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.6-rc6

for you to fetch changes up to 11a4a8f73b3ce71b32f36e9f1655f6ddf8f1732b:

  clang-format: Update with the latest for_each macro list (2020-03-06 21:50:05 +0100)

----------------------------------------------------------------
Another update for the .clang-format macro list

It has been a while since the last time I sent one!

----------------------------------------------------------------
Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

 .clang-format | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)
