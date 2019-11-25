Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F681087EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 05:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKYEhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Nov 2019 23:37:42 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:46102 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfKYEhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 23:37:41 -0500
Received: by mail-ua1-f52.google.com with SMTP id i31so3952558uae.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 20:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bwQqTlKTDKZ2abMdWNVOtZUSwtWKOhRAhvsBA2Mpx5I=;
        b=fuSHOk3aA1DgmMXAvf4yqAMpCZDfU7RBqCAM75G5MmJd4jFAgJCnJE47ohYW1tHmLz
         5j+TwUBSQOFIKh8KtzBPOoDXoXX1RihAxy+aX7++qKTaow5CrgUpwI011hDmJJp0Vg+d
         8YdM+6vl3Tpm9OdOYFNTuqm+nVN86o1o9BoEpReo63f5wTUcuAMAdwsLS2sTNprVdrSc
         VjnE4HdyNbXt53tfgnXTwgPO3HEqzjCxhPv9DMk9zyvcRsu2R6UZ8119F21J3wqKez6G
         BfgbTPYGpKCem7op6F/boQiT9U24OKtuvSHXLduew/l/zcmczv9aIbE3zEBM4xQ6i9ib
         ncsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bwQqTlKTDKZ2abMdWNVOtZUSwtWKOhRAhvsBA2Mpx5I=;
        b=Qc8JcZm+6KDi1WwLIrFL39zyO3DREaSrLnJXTX1u+Y+VDmuaqqUThSs1B1tqIDQTQX
         MAc/3MCOBC/SxoiedwaouPMu+TbuXbazuu2rfrRQaqJ2Ty5zslOgGcAJaDOFOmTGMck7
         yxLepjIHSl+Gxdgst68D9hCMcYhzHAQKhMBwnDJzzV6pIwpAqPhOSfkTKccgqEl4P7BD
         rLn3A2T1dqiDG6WOjSzk97WLk6sxkmddoE6wlfJ9bow+o80bGjGkhV4k/4hpKuGU0KCp
         /oZCq9IU0rWrW0MS9K7Bbabl7HbRKSn7xteT5U9NBXPGRQQ9eM0oBFH9I4nCjvvMKfFe
         beaA==
X-Gm-Message-State: APjAAAVr/axtPI2hRCLReV7oa++a9pfMlIb5vg1vYZ1JlK7kDENlkIT/
        wx3O4jcvRSVpxngI3nSQ4dts7APfRVG1tw==
X-Google-Smtp-Source: APXvYqyYfS/umk3C9WJ6m+ltXeTQDzU2ehX1ACDpitE/Nf9SkmILFLc9ZOhVD6PuLqh3XC73KE78QA==
X-Received: by 2002:ab0:49e9:: with SMTP id f38mr16314359uad.71.1574656659044;
        Sun, 24 Nov 2019 20:37:39 -0800 (PST)
Received: from ubuntu1804-desktop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id r64sm1818020vkd.9.2019.11.24.20.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 20:37:38 -0800 (PST)
Date:   Sun, 24 Nov 2019 23:37:37 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org
Subject: [RFC v2 0/2] docs: ftrace: Clarify the RAM impact of buffer_size_kb
Message-ID: <cover.1574655670.git.frank@generalsoftwareinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarifies the RAM footprint of buffer_size_kb without getting into
implementation details.

Changes in v2:
  - Removes implementation description of the RAM footprint of
    buffer_size_kb, but still make the corresponded clarification.

  - Removes a patch that was just for illustration purposes because
    Steven already got the issue that I was referring to.

  - Adds a patch to fix other typos in the doc.

Frank A. Cancio Bello (2):
  docs: ftrace: Clarify the RAM impact of buffer_size_kb
  docs: ftrace: Fix typos

 Documentation/trace/ftrace.rst             | 9 +++++----
 Documentation/trace/ring-buffer-design.txt | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.17.1

