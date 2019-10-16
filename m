Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2AD9047
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 14:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfJPMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 08:02:32 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:46893 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfJPMCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:02:30 -0400
Received: by mail-yb1-f171.google.com with SMTP id h202so7686337ybg.13;
        Wed, 16 Oct 2019 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOhSKFRNbWN9yAKzmfHZhTX3n/eFbcTEsWwMp45CFAs=;
        b=TyIjvHv1QNRUaN9ssWTSYEbK8f71Pqr3Kvr83aPOr/hw6LT/GfgSrLD2+591ntEA1+
         8GsDrCPs48egEjJ4IwvVxdlmj1RVflJKN7/0COHg+ZFp+px7zTN1JjUgLn2Gqzs+PEkL
         4lOaIXR+OIh2v9fVniopcIyvdHCIr9Qk9Uy9YIYX4SL5XE0Sd/No7WHReeCMLC+lxowG
         fuXrJt0dRRzsPu9JOhTEg6lzRY7Vto2uGYpwzF2hivVskp4GrooW/vWjJDTTfjpJOIu7
         /yWF944aOvp8Kn/h8XCmrR8Auc10Yu7QcN1/LIqWasRL4906nTIQ9LfJ9hQJol8YidHP
         w9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOhSKFRNbWN9yAKzmfHZhTX3n/eFbcTEsWwMp45CFAs=;
        b=moLOURSrbXjuvb3AAdXAtTIykj5nrpwAIq8alUzptr9inmYkveW3QLOLunjgT/zNDq
         B+26YbM6RrH9XY4hiWergf7r5kKOkP69/TXm1ramwqDJuZ2HFE5CPAQX8IvfHgcX+th8
         R/U9cJhvJBb+4P6RLbqfdF/Pb9stCyEJdOwyQFwSSAsySo+dsyzuULy0sABYLc7AZon3
         1g6yeQEi+nX0CxgtZgnyQwlUFWCXI9GqIg3xI5vYeBmtmkqnWrfyhOhj22reRLC/XiaQ
         Y7qSh4CEWWFg1U3zF/NUxuRstBcFXgmuVzP/vVV+30cn7YQubJ1lyDYNE277refe9w6M
         Hqwg==
X-Gm-Message-State: APjAAAWRbwJDnHL2Dqe2f/lwzeUobv6wkIac8tVFHtPkFldYvFuC2ITW
        ndrN/v8JnNc/eaEmk6snxAhKEIPDX0piZDUau9c=
X-Google-Smtp-Source: APXvYqyKwoSy9uDdUFDL7IGWquqEML0FnzeC6V6viQRoFG5+7DuKUjwaS7f9Rs5Uelml6CR6n79ZYlIgLQA9f2e/vGc=
X-Received: by 2002:a25:cdca:: with SMTP id d193mr27663420ybf.60.1571227349079;
 Wed, 16 Oct 2019 05:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191015123830.GA1797@ls3530.fritz.box> <157115910290.6841.17729342283243489680.pr-tracker-bot@kernel.org>
In-Reply-To: <157115910290.6841.17729342283243489680.pr-tracker-bot@kernel.org>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Wed, 16 Oct 2019 14:02:17 +0200
Message-ID: <CA+QBN9D+hg3PkJG9Wb99TqK7AHb-tVEo3R7Um0zuegqc_YTqrA@mail.gmail.com>
Subject: working PCI SATA cards
To:     pr-tracker-bot@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi
after weeks of testing activities, I confirm the following SATA cards
do work with C3600 workstation running Linux >= 5.1

- HighPoint RocketRAID 2224
- Highpoint RocketRAID 1640
- SYBA-SY-PCX40009
- Adaptec 1210SA
