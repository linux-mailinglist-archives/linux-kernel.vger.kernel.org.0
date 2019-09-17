Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51414B5652
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 21:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfIQTlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 15:41:52 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:44675 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfIQTlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:41:51 -0400
Received: by mail-lf1-f46.google.com with SMTP id q11so3800194lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=2wIqHgo/8bnd2n8GrOghGpsD7glGx9O2YeTzOGqjFX8=;
        b=oJbZc/qYSVVSmNWfreeBfiwaUGh9dcetmArap/5uRSH6s+5r/rtfVR9sHeCnHEKG8s
         Nhodf6Jd5GCEHWXStLUtSFYTtShlk7v8F79c8Th6Hxi6ZSXHZMC5RiJOV9nAbwQ4giIw
         TMsoEZ2+NQKE6QK3qbfkbzYILME1fHENnifWkmu2nTBF7ERzqXjyPFicqDSBOf0bp20g
         rtII1lOAikEBZrJBCsryMPwEfxfaLufNHvkunjIMlQDdC7xxtPjuutqUzhJrRiEMpyM1
         CMKljzy3rEz7E5QVYcJt5uCmrkPJtVczpnLowgJ66pVmY0uu3FJD0N8aF38fHkopH+4m
         KG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2wIqHgo/8bnd2n8GrOghGpsD7glGx9O2YeTzOGqjFX8=;
        b=qsboeR/ppZ9/lJdcOFkCCnPSM08LsYcYqb3oR1vS/QV1u/XTU4lY8eXNGYLvNL5X+3
         UaruF+E6zRVLFANR7zkfJjEe6c9Hgd6cIUbQfKaZfxXPKThm1fNWGiKVMuehQ6oPCij5
         wVFzoMB9VedcnSYqTdqpnp/YhSAil0URWt5sesWuV5ZmdUlqRpLYbDwwXDKU0v73oRZd
         2C6el+tTgux3uQYVDMbSEsx25R3KIkLrK3uSDav0dKt9T7BhaXcn4vWny5szoe2x0+kj
         cng26ATzPrjJKSV5NK8ljzQFQzaiBcsxlRVdHzd3UszScV5FGx6j4Vl1cOnxg+znCKNg
         ZqqA==
X-Gm-Message-State: APjAAAX29xvTcxQWRBawTYCQi8bypad75eR/uZuihv1ZGpz/MYIrBrxu
        9+XOhmndnZTTY6nZj6fWmgIm1UA2Cz3iO5Mc2kCzKBpR5g==
X-Google-Smtp-Source: APXvYqxX0YkdZ0wFDpZ6BG3mduELSXH0XrNoE6+UpQWNVMd+Prz9z6TM8/6xggxjbBpCr5mQdInBZJA9xZoJEIobQVQ=
X-Received: by 2002:a19:6517:: with SMTP id z23mr1307lfb.31.1568749310105;
 Tue, 17 Sep 2019 12:41:50 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Sep 2019 15:41:39 -0400
Message-ID: <CAHC9VhTe5vDJGsyQp+iHNQnK+SX9HSmsqnas44+eeNkFiFJZpw@mail.gmail.com>
Subject: No audit/next patches for the v5.4 merge window
To:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A quick note in case anyone was wondering ... we don't have anything
queued up in audit/next for the v5.4 merge window, so no audit updates
this time around.

-- 
paul moore
www.paul-moore.com
