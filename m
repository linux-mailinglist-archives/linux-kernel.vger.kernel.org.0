Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF855AE787
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 12:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405491AbfIJKD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 06:03:26 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:49481 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405459AbfIJKDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:03:25 -0400
Received: by mail-pl1-f201.google.com with SMTP id p8so9520707plo.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r40Km9SeMoEAm8w6fV7cNpDnhYcE+rjMqoH130Kp7BE=;
        b=sHdbong61Qoi+BbIKKGln345Qiy3DeqhOHgCul55SvBFdXYKycYt9HdpvP4vOwUtRA
         e6XeqPWVJfzS8Mprr6lyw7diodw1kI/Clox6b/90uCbDDsTULGvWnAwQID0XOxQeRwrr
         FP6UHyX3aP1J8Df1uaoNBjipHfLQ/ayxBfs5HDNGp14O4t7RA5VC3Y4o3xEyijxcunTp
         1dR/Ptyb6pyaczugc9pQYj9p4E9ce7jzRL41Y7FnTms/phFh8IEDvs/g1FJHXtyRdojh
         O0gxHJNkgFQDTwYt4kzQu7N1y6wiJwzj4TkX+lW3IifPWc2FAPyKZIcjOKtnruuocAwo
         xlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r40Km9SeMoEAm8w6fV7cNpDnhYcE+rjMqoH130Kp7BE=;
        b=mEoXrvb5qHPOtzlWI+/ZB9rR3Ff34M9NA23sEu4v4KHIuuLd4bnPgExwPkh1bB0Y/X
         nu4B8qG2ntZI5m5E7AodM3Z0qa4BbqX152sfsVkoPaBqwE1TCO3EuY/agTIcCADkrWhL
         pPgZGRC5wMhNHYdyoBtMDc9Srd6GWF2VVFw9kAKYNHYtmqCGEwX4tASean6pxdY/aehK
         46PUojIya3bP69UJSwu6HNRGjsTd2Rzj4eVqiGBTwLUNoj7h0ueCKl7YBHufBz5R+CHy
         rvdcd4UkGxllcyogCLI4AG1ze4IsB/qIkfL1LowAae04eA4gG1oX06pPaxVAMRAUwlUg
         2r2w==
X-Gm-Message-State: APjAAAW4LX69uQ4jx4yjK147Z/kpikRSXVT+yaNc91aMrnhZZMsLuoD8
        KEAOJ8H/3w4IO4aw/GTkLO+AnBPmHB4nVPfb8fZlpQ==
X-Google-Smtp-Source: APXvYqym4YdfN5NCZ635dtgyN0Mo3OO0Abij86ACeO+9MdGWn1hlEjvLlL151v1Oriv9nU/uiKBEfgMcr+VXJAs55COPww==
X-Received: by 2002:a65:6904:: with SMTP id s4mr26903237pgq.33.1568109803251;
 Tue, 10 Sep 2019 03:03:23 -0700 (PDT)
Date:   Tue, 10 Sep 2019 03:03:16 -0700
Message-Id: <20190910100318.204420-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH 0/2] Minor lockdown fixups
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify some arrays and fix an #ifdef that I typoed.


