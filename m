Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D711BF09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 22:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLKVUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 16:20:49 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:42857 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKVUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:20:49 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M7KKA-1ie1M44Aw8-007mLg; Wed, 11 Dec 2019 22:20:33 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v7 6/9] ALSA: Avoid using timespec for struct snd_timer_tread
Date:   Wed, 11 Dec 2019 22:20:22 +0100
Message-Id: <20191211212025.1981822-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211212025.1981822-1-arnd@arndb.de>
References: <20191211212025.1981822-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+tXKyrv5Gu7v2t25ECNCbOk7zKudAIRzHrqH5nxAc6/1yLE3gQd
 AUMmhejroRygikXX/2sNYEBkfBtACMpLWpl0c7hzKiodIiOwPO4mcV5hW4F142pQfCsuLXp
 wXRf8ymtycQf33D7HLca7mHrsxPs/9T7VgSjevbKSDeduz1xYmveHkYiJDBIbsvqSXCwWs0
 k6ouCeVnFzvKOyLSBakhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Lzlap6hiJQ=:woPa0nACL6/CB3vIZ1L+XU
 Jpsy5q0/sfOeabJeJnUUuI+04+d65m8+bKFHEFpex+EuIq9Ne3hL1j09H9AE6Gbb47DOcr9li
 hrYAxLL+rYHcEPikHfzEoFgTPENXzr+5EwnQwItUuJ1Xo58NYgt0bdsxSdWZQD/7BYG8tqIs4
 xTxA5Ik3iRJam5gf3k7psI79r8bW/Rxth8mlQY00E7MPKY0rgN/VCvrrOfz2PshAfTEEaLJne
 9sfNQsd+705rFSzGSvcXRfxvJcbvdj+lIPgOW7b4CQKTESE7sXGM3eFZYSMUs4fbaBEgMXmBb
 g/cmmZxpw5txdSG8kASAG79RmkQjRNqrr5HaVtf3VEzlbTA7giKBJB3FDvNTUHfM++fZajLAf
 1OGPz0oH35wZ+sI8kmw0/3LJiMBzkXGaJHdYIumGm9ztYNxX2nA8wmv39NfC1tfyzCZ/78IEa
 /akOw8xNb5IL/ay7K8IAFH1p79Gp2e6DmqNDMfQvkjbt9DEFnoatm9by3TeaW7Gu9X+CSqVp6
 lHZ72xpkaQCGNxRUonLgcIrSp8+z8L106pFoevd9ZKI9Pp8wVzzs/5mnOmvyWlgFmT5wpmPAD
 2ZBjxEvWXBbduSpaY+hNh3gpstDcrH8WNebqvgb2Boo+YMDwqSJ70B9OzdYqnLgqjaTSe34Ui
 fMzcZuO+GOFRvMr2Ivj8N5JpdwCtA2jXY/R7pqz520c9nEhDY2Q3msXQlpXy5DKIZHBLbj/g5
 B3wcs6IYHf+bnb1pA5+bfJObPnkSbAbO6mqya8itYmhzhpqvQDB4DdaOz17/K3HXDwPHDlQUf
 zUV5aNforIwrPJmCeKWomHQ/cgEcCC7VzLkrTE7mj5rFPw2AxSXpe2SwzOScCNctnG4ra243k
 81WAiYUO1X4qeZJpXoNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

The struct snd_timer_tread will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Since the struct snd_timer_tread is passed through read() rather than
ioctl(), and the read syscall has no command number that lets us pick
between the 32-bit or 64-bit version of this structure.

Thus we introduced one new command SNDRV_TIMER_IOCTL_TREAD64 and new
struct snd_timer_tread64 replacing timespec with s64 type to handle
64bit time_t. That means we will set tu->tread = TREAD_FORMAT_64BIT
when user space has a 64bit time_t, then we will copy to user with
struct snd_timer_tread64. Otherwise we will use 32bit time_t variables
when copying to user.

Moreover this patch replaces timespec type with timespec64 type and
related y2038 safe APIs.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/sound/asound.h |  15 +++-
 sound/core/timer.c          | 149 +++++++++++++++++++++++++++---------
 sound/core/timer_compat.c   |   5 +-
 3 files changed, 130 insertions(+), 39 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index e0ada33afa1e..ad86c5a7a1e2 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -783,7 +783,7 @@ struct snd_timer_status {
 
 #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
 #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
-#define SNDRV_TIMER_IOCTL_TREAD		_IOW('T', 0x02, int)
+#define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
 #define SNDRV_TIMER_IOCTL_GINFO		_IOWR('T', 0x03, struct snd_timer_ginfo)
 #define SNDRV_TIMER_IOCTL_GPARAMS	_IOW('T', 0x04, struct snd_timer_gparams)
 #define SNDRV_TIMER_IOCTL_GSTATUS	_IOWR('T', 0x05, struct snd_timer_gstatus)
@@ -796,6 +796,15 @@ struct snd_timer_status {
 #define SNDRV_TIMER_IOCTL_STOP		_IO('T', 0xa1)
 #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
 #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
+#define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
+
+#if __BITS_PER_LONG == 64
+#define SNDRV_TIMER_IOCTL_TREAD SNDRV_TIMER_IOCTL_TREAD_OLD
+#else
+#define SNDRV_TIMER_IOCTL_TREAD ((sizeof(__kernel_long_t) >= sizeof(time_t)) ? \
+				 SNDRV_TIMER_IOCTL_TREAD_OLD : \
+				 SNDRV_TIMER_IOCTL_TREAD64)
+#endif
 
 struct snd_timer_read {
 	unsigned int resolution;
@@ -821,11 +830,15 @@ enum {
 	SNDRV_TIMER_EVENT_MRESUME = SNDRV_TIMER_EVENT_RESUME + 10,
 };
 
+#ifndef __KERNEL__
 struct snd_timer_tread {
 	int event;
+	__time_pad pad1;
 	struct timespec tstamp;
 	unsigned int val;
+	__time_pad pad2;
 };
+#endif
 
 /****************************************************************************
  *                                                                          *
diff --git a/sound/core/timer.c b/sound/core/timer.c
index d2f69039f941..b33fd63ce923 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -44,6 +44,28 @@ MODULE_PARM_DESC(timer_tstamp_monotonic, "Use posix monotonic clock source for t
 MODULE_ALIAS_CHARDEV(CONFIG_SND_MAJOR, SNDRV_MINOR_TIMER);
 MODULE_ALIAS("devname:snd/timer");
 
+enum timer_tread_format {
+	TREAD_FORMAT_NONE = 0,
+	TREAD_FORMAT_TIME64,
+	TREAD_FORMAT_TIME32,
+};
+
+struct snd_timer_tread32 {
+	int event;
+	s32 tstamp_sec;
+	s32 tstamp_nsec;
+	unsigned int val;
+};
+
+struct snd_timer_tread64 {
+	int event;
+	u8 pad1[4];
+	s64 tstamp_sec;
+	s64 tstamp_nsec;
+	unsigned int val;
+	u8 pad2[4];
+};
+
 struct snd_timer_user {
 	struct snd_timer_instance *timeri;
 	int tread;		/* enhanced read with timestamps and events */
@@ -55,7 +77,7 @@ struct snd_timer_user {
 	int queue_size;
 	bool disconnected;
 	struct snd_timer_read *queue;
-	struct snd_timer_tread *tqueue;
+	struct snd_timer_tread64 *tqueue;
 	spinlock_t qlock;
 	unsigned long last_resolution;
 	unsigned int filter;
@@ -1329,7 +1351,7 @@ static void snd_timer_user_interrupt(struct snd_timer_instance *timeri,
 }
 
 static void snd_timer_user_append_to_tqueue(struct snd_timer_user *tu,
-					    struct snd_timer_tread *tread)
+					    struct snd_timer_tread64 *tread)
 {
 	if (tu->qused >= tu->queue_size) {
 		tu->overrun++;
@@ -1346,7 +1368,7 @@ static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 				     unsigned long resolution)
 {
 	struct snd_timer_user *tu = timeri->callback_data;
-	struct snd_timer_tread r1;
+	struct snd_timer_tread64 r1;
 	unsigned long flags;
 
 	if (event >= SNDRV_TIMER_EVENT_START &&
@@ -1356,7 +1378,8 @@ static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 		return;
 	memset(&r1, 0, sizeof(r1));
 	r1.event = event;
-	r1.tstamp = timespec64_to_timespec(*tstamp);
+	r1.tstamp_sec = tstamp->tv_sec;
+	r1.tstamp_nsec = tstamp->tv_nsec;
 	r1.val = resolution;
 	spin_lock_irqsave(&tu->qlock, flags);
 	snd_timer_user_append_to_tqueue(tu, &r1);
@@ -1378,7 +1401,7 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 				      unsigned long ticks)
 {
 	struct snd_timer_user *tu = timeri->callback_data;
-	struct snd_timer_tread *r, r1;
+	struct snd_timer_tread64 *r, r1;
 	struct timespec64 tstamp;
 	int prev, append = 0;
 
@@ -1399,7 +1422,8 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 	if ((tu->filter & (1 << SNDRV_TIMER_EVENT_RESOLUTION)) &&
 	    tu->last_resolution != resolution) {
 		r1.event = SNDRV_TIMER_EVENT_RESOLUTION;
-		r1.tstamp = timespec64_to_timespec(tstamp);
+		r1.tstamp_sec = tstamp.tv_sec;
+		r1.tstamp_nsec = tstamp.tv_nsec;
 		r1.val = resolution;
 		snd_timer_user_append_to_tqueue(tu, &r1);
 		tu->last_resolution = resolution;
@@ -1413,14 +1437,16 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 		prev = tu->qtail == 0 ? tu->queue_size - 1 : tu->qtail - 1;
 		r = &tu->tqueue[prev];
 		if (r->event == SNDRV_TIMER_EVENT_TICK) {
-			r->tstamp = timespec64_to_timespec(tstamp);
+			r->tstamp_sec = tstamp.tv_sec;
+			r->tstamp_nsec = tstamp.tv_nsec;
 			r->val += ticks;
 			append++;
 			goto __wake;
 		}
 	}
 	r1.event = SNDRV_TIMER_EVENT_TICK;
-	r1.tstamp = timespec64_to_timespec(tstamp);
+	r1.tstamp_sec = tstamp.tv_sec;
+	r1.tstamp_nsec = tstamp.tv_nsec;
 	r1.val = ticks;
 	snd_timer_user_append_to_tqueue(tu, &r1);
 	append++;
@@ -1435,7 +1461,7 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 static int realloc_user_queue(struct snd_timer_user *tu, int size)
 {
 	struct snd_timer_read *queue = NULL;
-	struct snd_timer_tread *tqueue = NULL;
+	struct snd_timer_tread64 *tqueue = NULL;
 
 	if (tu->tread) {
 		tqueue = kcalloc(size, sizeof(*tqueue), GFP_KERNEL);
@@ -1874,11 +1900,11 @@ static int snd_timer_user_params(struct file *file,
 	tu->qhead = tu->qtail = tu->qused = 0;
 	if (tu->timeri->flags & SNDRV_TIMER_IFLG_EARLY_EVENT) {
 		if (tu->tread) {
-			struct snd_timer_tread tread;
+			struct snd_timer_tread64 tread;
 			memset(&tread, 0, sizeof(tread));
 			tread.event = SNDRV_TIMER_EVENT_EARLY;
-			tread.tstamp.tv_sec = 0;
-			tread.tstamp.tv_nsec = 0;
+			tread.tstamp_sec = 0;
+			tread.tstamp_nsec = 0;
 			tread.val = 0;
 			snd_timer_user_append_to_tqueue(tu, &tread);
 		} else {
@@ -2008,6 +2034,36 @@ static int snd_timer_user_pause(struct file *file)
 	return 0;
 }
 
+static int snd_timer_user_tread(void __user *argp, struct snd_timer_user *tu,
+				unsigned int cmd, bool compat)
+{
+	int __user *p = argp;
+	int xarg, old_tread;
+
+	if (tu->timeri)	/* too late */
+		return -EBUSY;
+	if (get_user(xarg, p))
+		return -EFAULT;
+
+	old_tread = tu->tread;
+
+	if (!xarg)
+		tu->tread = TREAD_FORMAT_NONE;
+	else if (cmd == SNDRV_TIMER_IOCTL_TREAD64 ||
+		 (IS_ENABLED(CONFIG_64BITS) && !compat))
+		tu->tread = TREAD_FORMAT_TIME64;
+	else
+		tu->tread = TREAD_FORMAT_TIME32;
+
+	if (tu->tread != old_tread &&
+	    realloc_user_queue(tu, tu->queue_size) < 0) {
+		tu->tread = old_tread;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 enum {
 	SNDRV_TIMER_IOCTL_START_OLD = _IO('T', 0x20),
 	SNDRV_TIMER_IOCTL_STOP_OLD = _IO('T', 0x21),
@@ -2016,7 +2072,7 @@ enum {
 };
 
 static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
-				 unsigned long arg)
+				 unsigned long arg, bool compat)
 {
 	struct snd_timer_user *tu;
 	void __user *argp = (void __user *)arg;
@@ -2028,23 +2084,9 @@ static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 		return put_user(SNDRV_TIMER_VERSION, p) ? -EFAULT : 0;
 	case SNDRV_TIMER_IOCTL_NEXT_DEVICE:
 		return snd_timer_user_next_device(argp);
-	case SNDRV_TIMER_IOCTL_TREAD:
-	{
-		int xarg, old_tread;
-
-		if (tu->timeri)	/* too late */
-			return -EBUSY;
-		if (get_user(xarg, p))
-			return -EFAULT;
-		old_tread = tu->tread;
-		tu->tread = xarg ? 1 : 0;
-		if (tu->tread != old_tread &&
-		    realloc_user_queue(tu, tu->queue_size) < 0) {
-			tu->tread = old_tread;
-			return -ENOMEM;
-		}
-		return 0;
-	}
+	case SNDRV_TIMER_IOCTL_TREAD_OLD:
+	case SNDRV_TIMER_IOCTL_TREAD64:
+		return snd_timer_user_tread(argp, tu, cmd, compat);
 	case SNDRV_TIMER_IOCTL_GINFO:
 		return snd_timer_user_ginfo(file, argp);
 	case SNDRV_TIMER_IOCTL_GPARAMS:
@@ -2084,7 +2126,7 @@ static long snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 	long ret;
 
 	mutex_lock(&tu->ioctl_lock);
-	ret = __snd_timer_user_ioctl(file, cmd, arg);
+	ret = __snd_timer_user_ioctl(file, cmd, arg, false);
 	mutex_unlock(&tu->ioctl_lock);
 	return ret;
 }
@@ -2100,13 +2142,28 @@ static int snd_timer_user_fasync(int fd, struct file * file, int on)
 static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 				   size_t count, loff_t *offset)
 {
+	struct snd_timer_tread64 *tread;
+	struct snd_timer_tread32 tread32;
 	struct snd_timer_user *tu;
 	long result = 0, unit;
 	int qhead;
 	int err = 0;
 
 	tu = file->private_data;
-	unit = tu->tread ? sizeof(struct snd_timer_tread) : sizeof(struct snd_timer_read);
+	switch (tu->tread) {
+	case TREAD_FORMAT_TIME64:
+		unit = sizeof(struct snd_timer_tread64);
+		break;
+	case TREAD_FORMAT_TIME32:
+		unit = sizeof(struct snd_timer_tread32);
+		break;
+	case TREAD_FORMAT_NONE:
+		unit = sizeof(struct snd_timer_read);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
 	mutex_lock(&tu->ioctl_lock);
 	spin_lock_irq(&tu->qlock);
 	while ((long)count - result >= unit) {
@@ -2145,14 +2202,34 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 		tu->qused--;
 		spin_unlock_irq(&tu->qlock);
 
-		if (tu->tread) {
-			if (copy_to_user(buffer, &tu->tqueue[qhead],
-					 sizeof(struct snd_timer_tread)))
+		tread = &tu->tqueue[qhead];
+
+		switch (tu->tread) {
+		case TREAD_FORMAT_TIME64:
+			if (copy_to_user(buffer, tread,
+					 sizeof(struct snd_timer_tread64)))
 				err = -EFAULT;
-		} else {
+			break;
+		case TREAD_FORMAT_TIME32:
+			memset(&tread32, 0, sizeof(tread32));
+			tread32 = (struct snd_timer_tread32) {
+				.event = tread->event,
+				.tstamp_sec = tread->tstamp_sec,
+				.tstamp_sec = tread->tstamp_nsec,
+				.val = tread->val,
+			};
+
+			if (copy_to_user(buffer, &tread32, sizeof(tread32)))
+				err = -EFAULT;
+			break;
+		case TREAD_FORMAT_NONE:
 			if (copy_to_user(buffer, &tu->queue[qhead],
 					 sizeof(struct snd_timer_read)))
 				err = -EFAULT;
+			break;
+		default:
+			err = -ENOTSUPP;
+			break;
 		}
 
 		spin_lock_irq(&tu->qlock);
diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index 20eef5bc304b..0103d16f6f9f 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -83,7 +83,8 @@ static long __snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case SNDRV_TIMER_IOCTL_PVERSION:
-	case SNDRV_TIMER_IOCTL_TREAD:
+	case SNDRV_TIMER_IOCTL_TREAD_OLD:
+	case SNDRV_TIMER_IOCTL_TREAD64:
 	case SNDRV_TIMER_IOCTL_GINFO:
 	case SNDRV_TIMER_IOCTL_GSTATUS:
 	case SNDRV_TIMER_IOCTL_SELECT:
@@ -97,7 +98,7 @@ static long __snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd,
 	case SNDRV_TIMER_IOCTL_PAUSE:
 	case SNDRV_TIMER_IOCTL_PAUSE_OLD:
 	case SNDRV_TIMER_IOCTL_NEXT_DEVICE:
-		return __snd_timer_user_ioctl(file, cmd, (unsigned long)argp);
+		return __snd_timer_user_ioctl(file, cmd, (unsigned long)argp, true);
 	case SNDRV_TIMER_IOCTL_GPARAMS32:
 		return snd_timer_user_gparams_compat(file, argp);
 	case SNDRV_TIMER_IOCTL_INFO32:
-- 
2.20.0

