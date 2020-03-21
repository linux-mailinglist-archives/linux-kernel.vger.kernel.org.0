Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B446B18E159
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 13:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgCUMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 08:50:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37022 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCUMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:50:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12so8788047otp.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HXE6tstiCEJgLEvZqX/al+c2Uj3U9XPUohG/1iBPeWI=;
        b=a4aq7LEoMR4j5IiQjNHy3uKrgcxeLZOZ8CDNKo6RxhTwsdYnFbdUZkcfo8GiUSP95K
         T+BULxm8IdodEXiWIQGOtvupc6IytfpIyYlGGRhPKzI9/r6w6xA6tB+hmcW5Vztqe+uM
         65DfYtTR/9eQ8XdMwDMlr5Mgv/uXky1ppDB9eRNNdatvOhXObyU9ekWz5hfpxQk31is4
         9Ct3EPyMhbY3lbQqhIjQAL9/02eYc1sxTibVHlIAX1LgqE6GfGPLDBlPkwxo6QymFCwH
         FClKH2Dq6ZMRsYZdCIcz2X9E2R6YghmxKi47TWMdspexLa+NuloT+JtnSPY9FIKmNcjz
         coTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=HXE6tstiCEJgLEvZqX/al+c2Uj3U9XPUohG/1iBPeWI=;
        b=kCROBrFwbseR4VQCTXcB+0Q8DLkas7TtwvikS0qckQuwN6qXLKLftzLMycnQB4NHhQ
         92cJbQ6/M8OZqFgxRQEZvjq8FF1ThSMToF3ssBnHfB9a0Gfmmm8ogPZE7ATe0CxIVlAW
         AQ4PVEPdKFYmBQduK2Merf4HKntpA/n8H50KOiZCT6bF59U2I5fHPkdRKfnOJGAct0Kt
         JZ6zKRtkPmiuclQGKoPuT5/V5vvfZyYAejsL+o8k5FRvPA5GxdzEqpod9tr3FQcsdDjL
         NtB192I7GqUpYVI6Q6zEBecp8opHTZbG3oEprF7S/IYk25Qaza0opznecVcH2nDgfQ6c
         AArg==
X-Gm-Message-State: ANhLgQ3gF6oS9SXorKahvRId5keMzecoih2aT3Aj3ShBuwAmxAYGn0o4
        rnmtCtzUryzi5a5Wx1ZCcEiCOMcNtA0yGSI82K8=
X-Google-Smtp-Source: ADFU+vsjxrZRHodH3kKTo79AK7LTrLO6lZoOXcfo5I7jttl9qT5bVWZWy/kMmMhsxWsWFWghAxUCvuiOeCqOHg/7RSc=
X-Received: by 2002:a05:6830:16cc:: with SMTP id l12mr10639490otr.234.1584795012277;
 Sat, 21 Mar 2020 05:50:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5785:0:0:0:0:0 with HTTP; Sat, 21 Mar 2020 05:50:11
 -0700 (PDT)
Reply-To: begabriel6543@hotmail.com
From:   Gabriel Bertrand <boxemail404@gmail.com>
Date:   Sat, 21 Mar 2020 05:50:11 -0700
Message-ID: <CAOLS_qSrk+zJN7-H59br1aY_WpXycd6epCp4DmXfOzx1BGmC-g@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQoNCuS9oOWlve+8jA0KDQrmiJHluIzmnJvkvaDlgZrnmoTlpb3jgIIg5b6I5oqx5q2J5Lul
6L+Z56eN5pa55byP5LiO5oKo6IGU57O744CCIOaIkeWPq0dhYnJpZWwgQmVydHJhbmTvvIzmiJHl
nKjms5Xlm73kuIDlrrbpooblhYjnmoTpk7booYzlt6XkvZzjgIINCuivt+ihqOaYjuaCqOacieWF
tOi2o+iOt+W+l+mBl+S6p+WfuumHke+8jOivpeasvumhueWxnuS6juWcqOS4jeW5uOS6i+aVheS4
reS4p+eUn+eahOWkluWbveWuouaIt+OAgg0KDQrkuIDml6bmgqjooajovr7kuobmgqjnmoTmhI/l
m77vvIzmiJHlsIbkuLrmgqjmj5Dkvpvmm7TlpJror6bnu4bkv6Hmga/jgIIg56Wd5oKo5pyJ5Liq
576O5aW955qE5LiA5aSp77ya6K+35LiO5oiR6IGU57O777yaPiBiZWdhYnJpZWw2NTQzQGdtYWls
LmNvbQ0KDQoNCuaIkeWcqOetieS9oOeahOWbnuWkjeOAgg0KDQrmnIDlpb3nmoTnpZ3npo/vvIwN
CuWKoOW4g+mHjOWfg+WwlMK35Lyv54m55YWwDQo=
