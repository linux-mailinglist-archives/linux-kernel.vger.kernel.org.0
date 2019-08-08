Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98431856BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 02:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfHHAH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 20:07:26 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48495 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbfHHAHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:25 -0400
Received: by mail-pl1-f201.google.com with SMTP id i33so54388635pld.15
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RA/AzJFbqTTjRNhYxA2E49Vb11Ruh+1EJHlxTueWjTY=;
        b=X3UXrNScaPGXcZrnUuHWqeCsi+0ba/hy6lA/tcRliqPEmv+PCWNVtiZ5NkTmWRUfWA
         FYXYef5PqQjgWqrA3Vaq3/yl3c8J7zWfN2qotCd+nXliqQ0i2psj1dpndL8y7vdKF+12
         7Xdr5s9Ea5Ci5KdN7azDmW5TRUnbHfuG8I9c+AoBKB+RvTfY0yQYbFsWBLDqu3GrLghj
         K9sj1BzMDrefvide68vZUJ3BlYFn9ABSac6mhMP7CVWcsO7Jn6iE8Z3HoDCZh+hAhNYD
         b88UuaMB7nNjBacqWnqCnGNoSLoe+/NjjX1GBfsvhrMfYpU2PccJW3YGI9FjR6URUeMu
         zzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RA/AzJFbqTTjRNhYxA2E49Vb11Ruh+1EJHlxTueWjTY=;
        b=HciBTY3UzLz2UIhwmY73aMbdHQnuZxyPj0xvkCRP1BboTq1LQX++MDqlU+4xq2dKJS
         Hn0yxCZFtFkHswOQinjVlqWhpC2uQPIClZ77YChbfES4GkEIJ8ekjljsDnbqWrRXkN6u
         fGcX6sq/24TK302iCUUil2ZBCRmr3ANJygba0JGu0P9Lo+YV/Y7WYWNWCjbIFTIi53NN
         ENZtAaIzF6vkBx6iKG8nXSB3MlMcmwqT94au+YGGg31GaRIaLtwOkc/HMmwICbuwZ9gt
         i7oda0yuZofyyVzWbG0VRn9FnwFSObwgDbReC9izQJzPhKSlP6JXD6ze/Nvj5t9BH5qW
         nsTg==
X-Gm-Message-State: APjAAAXE026OeyPzljA1TTtXTrJf+EEjSkKKekoh2AYz1Ul+GFZfpIBo
        q/nsCZQUItuk/Dvp1tATLhJJamVSzac66BtfoPs/xA==
X-Google-Smtp-Source: APXvYqxt5HteYlNYSyG0H4Bdm+j8ER0YvN1NzjCzMXnO3nx4gpqpTHXi3q+FUGWL6wetdciOWJ3PzX6gavYgbpYrXeQlmg==
X-Received: by 2002:a65:6096:: with SMTP id t22mr8991690pgu.204.1565222844769;
 Wed, 07 Aug 2019 17:07:24 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:06:52 -0700
Message-Id: <20190808000721.124691-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 00/29] security: Add support for locking down the kernel
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed an unused function parameter in patch 19, otherwise identical to
V37.


