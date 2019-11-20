Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B11043B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 19:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKTSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 13:54:08 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35176 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfKTSyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:54:07 -0500
Received: by mail-wr1-f52.google.com with SMTP id s5so1211115wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JptNQ6so/9L3uvOwNdnkFnNevzjTCJ/2Jz7F6P16UNE=;
        b=t+0eJWavqPUHbmxDSFHnMGlmo9Q3X+wlZx5uhAfbHsAyeYo0VVf7Y8pTOy++2yUZ4Z
         phaEFG/Ck1KeN8ThPLqr9Ozs9/ITN4nVY7IRsfQ1ookLfhAwdgnpiaugBiXyhD6FIJjN
         Lme6gu4ys5MP4bpj8PDqcZph0uoziTKcrOKRIE2eACdLa1ESGUDR81aP3wc6ana1LDST
         jFRm89AcHzBzsm9juUURKOIduF+D6NoWBKNaUseZRnD7E92hCGrMT99hc7YQbBmrAn7b
         dYzffqSjtrfyptP5AZJOc8JtkNK8dGjxF8ZaHJvMS9movSDlDjco4eJcWE9lWRaQPeR2
         kHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JptNQ6so/9L3uvOwNdnkFnNevzjTCJ/2Jz7F6P16UNE=;
        b=SN5pJ/g4tQPHy3uJx7uO6BrE2MQ5m++Fu/KQ25/lqcQ7ybAG5jhkRVi0yDJNnU47vX
         5Y6nNaHlFIy199bQVw1ePuzr23XwKGxPfT2NquAW8CQEddB/vmhnj3TuKLNMzNWniz1F
         6cGAqJIR4LSmml82/ryVug630ekKNrOEIaBmydXtMjdA/uYWkjh4tzMPb+3p1yC31VUO
         FLiK64ANxr7zgZGZkD6igcOomlWL6PMSajvJNx2jr1yo/G124atWlxDGwGkBhwAkUhY1
         fYZ9aMW1//YizFnpw8M1KzWX13G4BgJLoRo2KbbIQu0kDTc91MwqMXtEKUAXEHqX5RPR
         oJmw==
X-Gm-Message-State: APjAAAWB1/Da/HaG2tt4+p3XtWfE+JlReF4b5kHORIrt890ZJYeKqwp4
        HkvjRDqqUpidOU6RF8eD2p6Bqj8dOemk6RbK4a3JSdio
X-Google-Smtp-Source: APXvYqxNhMGn8X0oE8DK0vvVrDFrzMq+rVAJfU7ecUReQ78bj7TF5i1/4tWwbSd2uL3jvJ/1wcaMKmciD/uKLsA1DSw=
X-Received: by 2002:adf:f308:: with SMTP id i8mr5319695wro.319.1574276045747;
 Wed, 20 Nov 2019 10:54:05 -0800 (PST)
MIME-Version: 1.0
From:   Pouneh Aghababazadeh <paghababazadeh@gmail.com>
Date:   Wed, 20 Nov 2019 10:53:54 -0800
Message-ID: <CAO0y-hsg-CJCgbaJr7JMVKZkmKakVnpZCq_4YPtczhX2f9nsbw@mail.gmail.com>
Subject: Question about creating EVM keys
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to experiment with user keys in EVM per the instructions
here: https://sourceforge.net/p/linux-ima/wiki/Home/#creating-trusted-and-evm-encrypted-keys
(the second block, for systems without TPM/don't have TPM ownership).

However, I'm getting the following error. Can you help me with this?

$ su -c 'keyctl pipe `keyctl search @u user kmk-user` > /etc/keys/kmk-user.blob'
Password:
keyctl_read_alloc: Permission denied

Thanks,
Pouneh
