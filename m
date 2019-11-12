Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE5F93E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 16:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKLPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 10:18:23 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:52667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLPSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:18:22 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MjjGX-1i1Z0V0o3f-00lHD0; Tue, 12 Nov 2019 16:16:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 0/8] Fix year 2038 issue for sound subsystem
Date:   Tue, 12 Nov 2019 16:16:34 +0100
Message-Id: <20191112151642.680072-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q40YMhArnA1qrhQ2RdM8wZz5GfDD4XNpqlTrpOmVwC+gbyXhmOZ
 qV/T2Y6DkLtzF/seEK7jmuHzlwVFf3cGDk0/z8m0aUloGeixvkey2txRLj89b6ka71w8Fe1
 FZ3HmrTsSmr7YBDa9HVQjzQ++yw2BC9a86ambympdYnV8Swm2q3lSMIgvDVUR0uekzu8eHN
 qbCtnl0EWuOAx1423zjpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:skDDT5SU3O0=:IPdBn0NcKN+R2RZXC0cA7T
 pOMxtfzHl+aOJg48lSA+KZY/ySgr78qFvMeCvodqvWZ34DADOs1zRiu5Ll5z04mChOVl4e5Er
 BkfxceDSFE1IGtc5W1gc2ylayqnkp79Q7gXTmAnUHTavYAv/eIg99mm4uABVDk19UGLDU5pOa
 rGgDZ53yu7n1UYooyJM0VicFnWJO/jWs9EGevPqB1ayPSRpGfRZ4xuX/OjAYRh7xgoKz+OdlG
 JsHOgHgYPNwSfsQI/Jf8rZIMdxUuHjCrPkD9DOo7ggNFvdXyWveSkUC5mLe95NwPRMk8mlBv+
 MlwXsTFUydaG0rtWZJLMg7bafX5pQF8As8HjW3ivFj95Gi12QPHNFaAxbO4Us3YE7DpQ4qOGL
 Lsg+MhbxPFQOrxEn7rH27cGmNPvlFjlrsvKVm2+H6ZCSExBqs6nc5jRWGPdunP/hhq1cgED28
 rrcDE31R/9sG4CsW2AA/Vcx0970gEECr0OEjEp6P7oFsYUwP9mNcYV0dL7p35/U5LD5aSTG50
 NvEx8Ga6g0P+7U4c5C9h2AGizgwL+shOB9ibHgUo+2405sIQcRZsehM/aycrcHl7fTC2gx4cF
 gzSXz3k873ilcuzmtJdUxpiK1d61ga97tGvPW4l8B9WFZgK1Yi/GUpqlr6MD3ICudiR6SxPsH
 nCwpytiULSg7GNq+t22PHNJRXMpCN3oCGds0D73CC1IRlL0mt8HUDSUzsbJMZJwULL0Aw6jbc
 UKns8GpcxB5gzq1h/Jud7rz7DjKd0j8J6F+mCUIgbPdVOj8UhFDTjlHJqW8Gabmt+EJUwPh+t
 rV2T2Q6YpgtK5q8G6PMBIG+zMe3SAcZt0B8CWN6QOd8bIElIM80PxPYsJ43VfQFEflKc5l3VJ
 tVBr2vSNXmfU/163rzzQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series I worked on with Baolin in 2017 and 2018, but we
never quite managed to finish up the last pieces. During the
ALSA developer meetup at ELC-E 2018 in Edinburgh, a decision was
made to go with this approach for keeping best compatibility
with existing source code, and then I failed to follow up by
resending the patches.

Now I have patches for all remaining time_t uses in the kernel,
so it's absolutely time to revisit them. I have done more
review of the patches myself and found a couple of minor issues
that I have fixed up, otherwise the series is still the same as
before.

Conceptually, the idea of these patches is:

- 64-bit applications should see no changes at all, neither
  compile-time nor run-time.

- 32-bit code compiled with a 64-bit time_t currently
  does not work with ALSA, and requires kernel changes and/or
  sound/asound.h changes

- Most 32-bit code using these interfaces will work correctly
  on a modified kernel, with or without the uapi header changes.

- 32-bit code using SNDRV_TIMER_IOCTL_TREAD requires the
  updated header file for 64-bit time_t support

- 32-bit i386 user space with 64-bit time_t is broken for
  SNDRV_PCM_IOCTL_STATUS, SNDRV_RAWMIDI_IOCTL_STATUS and
  SNDRV_PCM_IOCTL_SYNC_PTR because of i386 alignment. This is also
  addressed by the updated uapi header.

- PCM mmap is currently supported on native x86 kernels
  (both 32-bit and 64-bit) but not for compat mode. This series breaks
  the 32-bit native mmap support for 32-bit time_t, but instead allows
  it for 64-bit time_t on both native and compat kernels. This seems to
  be the best trade-off, as mmap support is optional already, and most
  32-bit code runs in compat mode anyway.

- I've tried to avoid breaking compilation of 32-bit code
  as much as possible. Anything that does break however is likely code
  that is already broken on 64-bit time_t and needs source changes to
  fix them.

I would like to propose merging this into the alsa tree after
the v5.5 merge window for inclusion into v5.6, to allow a good
amount of testing, in particular for the header changes that
may cause problems for user space applications.

A git branch with the same contents is available for testing at [1].

Please review and test!

     Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-alsa
[2] https://lore.kernel.org/lkml/CAK8P3a2Os66+iwQYf97qh05W2JP8rmWao8zmKoHiXqVHvyYAJA@mail.gmail.com/T/#m6519cb07cfda08adf1dedea6596bb98892b4d5dc

Changes since v5 (Arnd):
 - Rebased to linux-5.4-rc4
 - Updated to completely remove timespec and time_t references from alsa
 - found and fixed a few bugs

Changes since v4 (Baolin):
 - Add patch 5 to change trigger_tstamp member of struct snd_pcm_runtime.
 - Add patch 8 to change internal timespec.
 - Add more explanation in commit message.
 - Use ktime_get_real_ts64() in patch 6.
 - Split common code out into a separate function in patch 6.
 - Fix tu->tread bug in patch 6 and remove #if __BITS_PER_LONG == 64 macro.

Changes since v3:
 - Move struct snd_pcm_status32 to pcm.h file.
 - Modify comments and commit message.
 - Add new patch2 ~ patch6.

Changes since v2:
 - Renamed all structures to make clear.
 - Remove CONFIG_X86_X32 macro and introduced new compat_snd_pcm_status64_x86_32.

Changes since v1:
 - Add one macro for struct snd_pcm_status_32 which only active in 32bits kernel.
 - Convert pcm_compat.c to use struct snd_pcm_status_64.
 - Convert pcm_native.c to use struct snd_pcm_status_64.

---

Arnd Bergmann (2):
  ALSA: move snd_pcm_ioctl_sync_ptr_compat into pcm_native.c
  ALSA: add new 32-bit layout for snd_pcm_mmap_status/control

Baolin Wang (6):
  ALSA: Replace timespec with timespec64
  ALSA: Avoid using timespec for struct snd_timer_status
  ALSA: Avoid using timespec for struct snd_ctl_elem_value
  ALSA: Avoid using timespec for struct snd_pcm_status
  ALSA: Avoid using timespec for struct snd_rawmidi_status
  ALSA: Avoid using timespec for struct snd_timer_tread

 include/sound/pcm.h               |  74 ++++++--
 include/sound/timer.h             |   4 +-
 include/uapi/sound/asound.h       | 132 ++++++++++++--
 sound/core/pcm.c                  |  12 +-
 sound/core/pcm_compat.c           | 282 ++++++++----------------------
 sound/core/pcm_lib.c              |  38 ++--
 sound/core/pcm_native.c           | 226 +++++++++++++++++++++---
 sound/core/rawmidi.c              | 132 +++++++++++---
 sound/core/rawmidi_compat.c       |  87 +++------
 sound/core/timer.c                | 229 ++++++++++++++++++------
 sound/core/timer_compat.c         |  62 +------
 sound/pci/hda/hda_controller.c    |  10 +-
 sound/soc/intel/skylake/skl-pcm.c |   4 +-
 13 files changed, 804 insertions(+), 488 deletions(-)

-- 
2.20.0

