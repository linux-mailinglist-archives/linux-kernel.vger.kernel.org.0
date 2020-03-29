Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39437196E78
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgC2Q3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 12:29:23 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37470 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2Q3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:29:23 -0400
Received: by mail-pj1-f65.google.com with SMTP id o12so6235548pjs.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iEkjz8u06vOISBGxB4lRlujekNouzi4buIL/sSK3jMc=;
        b=U3h6GlAnA+l6ORPhAmf5F7XQ7rmz+KXE1FEUWO1iUU7njc+AvITzL4VIwgHi+0lMj+
         Bdw4gy4DQ7IdQR2EjgdotSCLKCatVz7lKxlGtHxL41ffConNffLYHDaYHghJaV1Kx0w0
         YBnuyBEEHynhCbNGQswACkB9QTfcB6uG0kS+zzMT82166kEyN0NohYvFon7Qo2nm2JCR
         iEt6zBQn8ctkfvP4CxRzDsvtRFTpEHK03ljQXPxJ9bE3eBKNTg4uTEKUrRdGCQYZbKz5
         TpG960OOfI/SsrAdWSPOGw3QbIeizgAKgOfbyBFCZmII1tP2OsoawL2Iq063wEfQSVgO
         pfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iEkjz8u06vOISBGxB4lRlujekNouzi4buIL/sSK3jMc=;
        b=bArWEjkz5SP8JHzMK5JdD/J5Uu2QrUo2CKx4GUw0GjtkiiiUJSFaGHPjtd+jk1OIge
         BHHjwhPtFBrIC+Szk4E25mGc5szcWX2bVH77quCfVMhAKJaes5j9bDLMRO6WUGGmvnfR
         QKlAiS2WBPyjT2QcmHzbhqIEeFMtcqpI1Kz0bCkRjBXDdfzfxqygPh+cAzidSNsLN2L7
         j7/r5poKS+eZ02WTFTPFmSwxS04JJ/4isT/75r8hZnoj2//6Tp7In+G5CfeEKI/zSijO
         HAoikzNBdm5oqIvTDkg73FNhqfJkfqJEpWwKvm4NrgkaIlCBd2oBnWlwgJyGG38WKGvm
         ebPw==
X-Gm-Message-State: ANhLgQ2QWLzhjJAQKsx32OXXvDantHxICPlDWK8sIIfhg4ErjndToA7v
        MRdJcyXxHN3ouu/4EsW+WAk=
X-Google-Smtp-Source: ADFU+vtmXixHCYI01s16TxtXfm/doNwSg468HaNPi6DrW7beNCaWqAXceG6RcGOhSJTYMG30352s1Q==
X-Received: by 2002:a17:90b:46d0:: with SMTP id jx16mr10997425pjb.155.1585499362031;
        Sun, 29 Mar 2020 09:29:22 -0700 (PDT)
Received: from localhost ([183.82.182.248])
        by smtp.gmail.com with ESMTPSA id lj14sm6599807pjb.25.2020.03.29.09.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 09:29:21 -0700 (PDT)
Date:   Sun, 29 Mar 2020 21:59:19 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Pending setup_irq() removal patches & core removal
Message-ID: <20200329162919.GA5317@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

i have sent the pending setup_irq() cleanup patches & the core removal
patch,

https://lkml.kernel.org/r/cover.1585320721.git.afzal.mohd.ma@gmail.com

sending this mail in case you missed noticing it as it was a bit deep in
the v1 thread (wasn't sure whether to send it as a new thread or as a
reply to v1, since you had replied on v1 though v2 was available at
that time, the patches were sent as a reply to v1 thread)

Regards
afzal

