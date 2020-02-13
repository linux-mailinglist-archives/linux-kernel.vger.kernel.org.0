Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5217D15C9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 18:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBMR51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 12:57:27 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:44183 "EHLO
        6.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgBMR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:57:27 -0500
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 12:57:13 EST
Received: from player715.ha.ovh.net (unknown [10.108.42.145])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id AF78A1596FF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 18:48:15 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id 0615DF2A6597;
        Thu, 13 Feb 2020 17:48:08 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH 1/6] docs: pretty up sysctl/kernel.rst
Date:   Thu, 13 Feb 2020 18:46:56 +0100
Message-Id: <20200213174701.3200366-2-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213174701.3200366-1-steve@sk2.org>
References: <20200213174701.3200366-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10078774493965929861
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrieekgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuffhomhgrihhnpehfrhhophdrohhrghdprhhsthdrthhonecukfhppedtrddtrddtrddtpdekkedruddvvddruddviedrudduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates sysctl/kernel.rst to use ReStructured Text more fully:
* the list of files is now the table of contents (old entries with no
  corresponding sections are added as empty sections for now);
* code references and commands are formatted as code, except for
  function names which end up linked to the appropriate documentation;
* links are used to point to other documentation and other sections;
* tables are used to make lists of values more readable (as already
  done for some sections);
* in heavily-reworked paragraphs, sentences are wrapped individually,
  to make future diffs easier to read.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 987 ++++++++++----------
 1 file changed, 493 insertions(+), 494 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index def074807cee..1de8f0b199b1 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -2,262 +2,188 @@
 Documentation for /proc/sys/kernel/
 ===================================
 
-kernel version 2.2.10
+Kernel version 2.2.10
 
 Copyright (c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
 
-Copyright (c) 2009,        Shen Feng<shen@cn.fujitsu.com>
+Copyright (c) 2009,        Shen Feng <shen@cn.fujitsu.com>
 
-For general info and legal blurb, please look in index.rst.
+For general info and legal blurb, please look in :doc:`index`.
 
 ------------------------------------------------------------------------------
 
 This file contains documentation for the sysctl files in
-/proc/sys/kernel/ and is valid for Linux kernel version 2.2.
+``/proc/sys/kernel/`` and is valid for Linux kernel version 2.2.
 
 The files in this directory can be used to tune and monitor
 miscellaneous and general things in the operation of the Linux
-kernel. Since some of the files _can_ be used to screw up your
+kernel. Since some of the files *can* be used to screw up your
 system, it is advisable to read both documentation and source
 before actually making adjustments.
 
 Currently, these files might (depending on your configuration)
-show up in /proc/sys/kernel:
-
-- acct
-- acpi_video_flags
-- auto_msgmni
-- bootloader_type	     [ X86 only ]
-- bootloader_version	     [ X86 only ]
-- cap_last_cap
-- core_pattern
-- core_pipe_limit
-- core_uses_pid
-- ctrl-alt-del
-- dmesg_restrict
-- domainname
-- hostname
-- hotplug
-- hardlockup_all_cpu_backtrace
-- hardlockup_panic
-- hung_task_panic
-- hung_task_check_count
-- hung_task_timeout_secs
-- hung_task_check_interval_secs
-- hung_task_warnings
-- hyperv_record_panic_msg
-- kexec_load_disabled
-- kptr_restrict
-- l2cr                        [ PPC only ]
-- modprobe                    ==> Documentation/debugging-modules.txt
-- modules_disabled
-- msg_next_id		      [ sysv ipc ]
-- msgmax
-- msgmnb
-- msgmni
-- nmi_watchdog
-- osrelease
-- ostype
-- overflowgid
-- overflowuid
-- panic
-- panic_on_oops
-- panic_on_stackoverflow
-- panic_on_unrecovered_nmi
-- panic_on_warn
-- panic_print
-- panic_on_rcu_stall
-- perf_cpu_time_max_percent
-- perf_event_paranoid
-- perf_event_max_stack
-- perf_event_mlock_kb
-- perf_event_max_contexts_per_stack
-- pid_max
-- powersave-nap               [ PPC only ]
-- printk
-- printk_delay
-- printk_ratelimit
-- printk_ratelimit_burst
-- pty                         ==> Documentation/filesystems/devpts.txt
-- randomize_va_space
-- real-root-dev               ==> Documentation/admin-guide/initrd.rst
-- reboot-cmd                  [ SPARC only ]
-- rtsig-max
-- rtsig-nr
-- sched_energy_aware
-- seccomp/                    ==> Documentation/userspace-api/seccomp_filter.rst
-- sem
-- sem_next_id		      [ sysv ipc ]
-- sg-big-buff                 [ generic SCSI device (sg) ]
-- shm_next_id		      [ sysv ipc ]
-- shm_rmid_forced
-- shmall
-- shmmax                      [ sysv ipc ]
-- shmmni
-- softlockup_all_cpu_backtrace
-- soft_watchdog
-- stack_erasing
-- stop-a                      [ SPARC only ]
-- sysrq                       ==> Documentation/admin-guide/sysrq.rst
-- sysctl_writes_strict
-- tainted                     ==> Documentation/admin-guide/tainted-kernels.rst
-- threads-max
-- unknown_nmi_panic
-- watchdog
-- watchdog_thresh
-- version
-
-
-acct:
-=====
+show up in ``/proc/sys/kernel``:
+
+.. contents:: :local:
+
+
+acct
+====
+
+::
 
-highwater lowwater frequency
+    highwater lowwater frequency
 
 If BSD-style process accounting is enabled these values control
 its behaviour. If free space on filesystem where the log lives
-goes below <lowwater>% accounting suspends. If free space gets
-above <highwater>% accounting resumes. <Frequency> determines
+goes below ``lowwater``% accounting suspends. If free space gets
+above ``highwater``% accounting resumes. ``frequency`` determines
 how often do we check the amount of free space (value is in
 seconds). Default:
-4 2 30
-That is, suspend accounting if there left <= 2% free; resume it
-if we got >=4%; consider information about amount of free space
-valid for 30 seconds.
 
+::
 
-acpi_video_flags:
-=================
+    4 2 30
+
+That is, suspend accounting if free space drops below 2%; resume it
+if it increases to at least 4%; consider information about amount of
+free space valid for 30 seconds.
 
-flags
 
-See Doc*/kernel/power/video.txt, it allows mode of video boot to be
-set during run time.
+acpi_video_flags
+================
 
+See Documentation/kernel/power/video.txt, it allows mode of video boot
+to be set during run time.
 
-auto_msgmni:
-============
+
+auto_msgmni
+===========
 
 This variable has no effect and may be removed in future kernel
 releases. Reading it always returns 0.
-Up to Linux 3.17, it enabled/disabled automatic recomputing of msgmni
-upon memory add/remove or upon ipc namespace creation/removal.
+Up to Linux 3.17, it enabled/disabled automatic recomputing of
+`msgmni`_
+upon memory add/remove or upon IPC namespace creation/removal.
 Echoing "1" into this file enabled msgmni automatic recomputing.
-Echoing "0" turned it off. auto_msgmni default value was 1.
+Echoing "0" turned it off. The default value was 1.
 
 
-bootloader_type:
-================
-
-x86 bootloader identification
+bootloader_type (x86 only)
+==========================
 
 This gives the bootloader type number as indicated by the bootloader,
 shifted left by 4, and OR'd with the low four bits of the bootloader
 version.  The reason for this encoding is that this used to match the
-type_of_loader field in the kernel header; the encoding is kept for
+``type_of_loader`` field in the kernel header; the encoding is kept for
 backwards compatibility.  That is, if the full bootloader type number
 is 0x15 and the full version number is 0x234, this file will contain
 the value 340 = 0x154.
 
-See the type_of_loader and ext_loader_type fields in
-Documentation/x86/boot.rst for additional information.
+See the ``type_of_loader`` and ``ext_loader_type`` fields in
+:doc:`/x86/boot` for additional information.
 
 
-bootloader_version:
-===================
-
-x86 bootloader version
+bootloader_version (x86 only)
+=============================
 
 The complete bootloader version number.  In the example above, this
 file will contain the value 564 = 0x234.
 
-See the type_of_loader and ext_loader_ver fields in
-Documentation/x86/boot.rst for additional information.
+See the ``type_of_loader`` and ``ext_loader_ver`` fields in
+:doc:`/x86/boot` for additional information.
 
 
-cap_last_cap:
-=============
+cap_last_cap
+============
 
 Highest valid capability of the running kernel.  Exports
-CAP_LAST_CAP from the kernel.
+``CAP_LAST_CAP`` from the kernel.
 
 
-core_pattern:
-=============
+core_pattern
+============
 
-core_pattern is used to specify a core dumpfile pattern name.
+``core_pattern`` is used to specify a core dumpfile pattern name.
 
 * max length 127 characters; default value is "core"
-* core_pattern is used as a pattern template for the output filename;
-  certain string patterns (beginning with '%') are substituted with
-  their actual values.
-* backward compatibility with core_uses_pid:
+* ``core_pattern`` is used as a pattern template for the output
+  filename; certain string patterns (beginning with '%') are
+  substituted with their actual values.
+* backward compatibility with ``core_uses_pid``:
 
-	If core_pattern does not include "%p" (default does not)
-	and core_uses_pid is set, then .PID will be appended to
+	If ``core_pattern`` does not include "%p" (default does not)
+	and ``core_uses_pid`` is set, then .PID will be appended to
 	the filename.
 
-* corename format specifiers::
-
-	%<NUL>	'%' is dropped
-	%%	output one '%'
-	%p	pid
-	%P	global pid (init PID namespace)
-	%i	tid
-	%I	global tid (init PID namespace)
-	%u	uid (in initial user namespace)
-	%g	gid (in initial user namespace)
-	%d	dump mode, matches PR_SET_DUMPABLE and
-		/proc/sys/fs/suid_dumpable
-	%s	signal number
-	%t	UNIX time of dump
-	%h	hostname
-	%e	executable filename (may be shortened)
-	%E	executable path
-	%<OTHER> both are dropped
+* corename format specifiers
+
+	========	==========================================
+	%<NUL>		'%' is dropped
+	%%		output one '%'
+	%p		pid
+	%P		global pid (init PID namespace)
+	%i		tid
+	%I		global tid (init PID namespace)
+	%u		uid (in initial user namespace)
+	%g		gid (in initial user namespace)
+	%d		dump mode, matches ``PR_SET_DUMPABLE`` and
+			``/proc/sys/fs/suid_dumpable``
+	%s		signal number
+	%t		UNIX time of dump
+	%h		hostname
+	%e		executable filename (may be shortened)
+	%E		executable path
+	%<OTHER>	both are dropped
+	========	==========================================
 
 * If the first character of the pattern is a '|', the kernel will treat
   the rest of the pattern as a command to run.  The core dump will be
   written to the standard input of that program instead of to a file.
 
 
-core_pipe_limit:
-================
+core_pipe_limit
+===============
 
-This sysctl is only applicable when core_pattern is configured to pipe
-core files to a user space helper (when the first character of
-core_pattern is a '|', see above).  When collecting cores via a pipe
-to an application, it is occasionally useful for the collecting
-application to gather data about the crashing process from its
-/proc/pid directory.  In order to do this safely, the kernel must wait
-for the collecting process to exit, so as not to remove the crashing
-processes proc files prematurely.  This in turn creates the
-possibility that a misbehaving userspace collecting process can block
-the reaping of a crashed process simply by never exiting.  This sysctl
-defends against that.  It defines how many concurrent crashing
-processes may be piped to user space applications in parallel.  If
-this value is exceeded, then those crashing processes above that value
-are noted via the kernel log and their cores are skipped.  0 is a
-special value, indicating that unlimited processes may be captured in
-parallel, but that no waiting will take place (i.e. the collecting
-process is not guaranteed access to /proc/<crashing pid>/).  This
-value defaults to 0.
-
-
-core_uses_pid:
-==============
+This sysctl is only applicable when `core_pattern`_ is configured to
+pipe core files to a user space helper (when the first character of
+``core_pattern`` is a '|', see above).
+When collecting cores via a pipe to an application, it is occasionally
+useful for the collecting application to gather data about the
+crashing process from its ``/proc/pid`` directory.
+In order to do this safely, the kernel must wait for the collecting
+process to exit, so as not to remove the crashing processes proc files
+prematurely.
+This in turn creates the possibility that a misbehaving userspace
+collecting process can block the reaping of a crashed process simply
+by never exiting.
+This sysctl defends against that.
+It defines how many concurrent crashing processes may be piped to user
+space applications in parallel.
+If this value is exceeded, then those crashing processes above that
+value are noted via the kernel log and their cores are skipped.
+0 is a special value, indicating that unlimited processes may be
+captured in parallel, but that no waiting will take place (i.e. the
+collecting process is not guaranteed access to ``/proc/<crashing
+pid>/``).
+This value defaults to 0.
+
+
+core_uses_pid
+=============
 
 The default coredump filename is "core".  By setting
-core_uses_pid to 1, the coredump filename becomes core.PID.
-If core_pattern does not include "%p" (default does not)
-and core_uses_pid is set, then .PID will be appended to
+``core_uses_pid`` to 1, the coredump filename becomes core.PID.
+If `core_pattern`_ does not include "%p" (default does not)
+and ``core_uses_pid`` is set, then .PID will be appended to
 the filename.
 
 
-ctrl-alt-del:
-=============
+ctrl-alt-del
+============
 
 When the value in this file is 0, ctrl-alt-del is trapped and
-sent to the init(1) program to handle a graceful restart.
+sent to the ``init(1)`` program to handle a graceful restart.
 When, however, the value is > 0, Linux's reaction to a Vulcan
 Nerve Pinch (tm) will be an immediate reboot, without even
 syncing its dirty buffers.
@@ -269,21 +195,22 @@ Note:
   to decide what to do with it.
 
 
-dmesg_restrict:
-===============
+dmesg_restrict
+==============
 
 This toggle indicates whether unprivileged users are prevented
-from using dmesg(8) to view messages from the kernel's log buffer.
-When dmesg_restrict is set to (0) there are no restrictions. When
-dmesg_restrict is set set to (1), users must have CAP_SYSLOG to use
-dmesg(8).
+from using ``dmesg(8)`` to view messages from the kernel's log
+buffer.
+When ``dmesg_restrict`` is set to 0 there are no restrictions.
+When ``dmesg_restrict`` is set set to 1, users must have
+``CAP_SYSLOG`` to use ``dmesg(8)``.
 
-The kernel config option CONFIG_SECURITY_DMESG_RESTRICT sets the
-default value of dmesg_restrict.
+The kernel config option ``CONFIG_SECURITY_DMESG_RESTRICT`` sets the
+default value of ``dmesg_restrict``.
 
 
-domainname & hostname:
-======================
+domainname & hostname
+=====================
 
 These files can be used to set the NIS/YP domainname and the
 hostname of your box in exactly the same way as the commands
@@ -302,167 +229,192 @@ hostname "darkstar" and DNS (Internet Domain Name Server)
 domainname "frop.org", not to be confused with the NIS (Network
 Information Service) or YP (Yellow Pages) domainname. These two
 domain names are in general different. For a detailed discussion
-see the hostname(1) man page.
+see the ``hostname(1)`` man page.
 
 
-hardlockup_all_cpu_backtrace:
-=============================
+hardlockup_all_cpu_backtrace
+============================
 
 This value controls the hard lockup detector behavior when a hard
 lockup condition is detected as to whether or not to gather further
 debug information. If enabled, arch-specific all-CPU stack dumping
 will be initiated.
 
-0: do nothing. This is the default behavior.
-
-1: on detection capture more debug information.
+= ============================================
+0 Do nothing. This is the default behavior.
+1 On detection capture more debug information.
+= ============================================
 
 
-hardlockup_panic:
-=================
+hardlockup_panic
+================
 
 This parameter can be used to control whether the kernel panics
 when a hard lockup is detected.
 
-   0 - don't panic on hard lockup
-   1 - panic on hard lockup
+= ===========================
+0 Don't panic on hard lockup.
+1 Panic on hard lockup.
+= ===========================
 
-See Documentation/admin-guide/lockup-watchdogs.rst for more information.  This can
-also be set using the nmi_watchdog kernel parameter.
+See :doc:`/admin-guide/lockup-watchdogs` for more information.
+This can also be set using the nmi_watchdog kernel parameter.
 
 
-hotplug:
-========
+hotplug
+=======
 
 Path for the hotplug policy agent.
-Default value is "/sbin/hotplug".
+Default value is "``/sbin/hotplug``".
 
 
-hung_task_panic:
-================
+hung_task_panic
+===============
 
 Controls the kernel's behavior when a hung task is detected.
-This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
-
-0: continue operation. This is the default behavior.
+This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
-1: panic immediately.
+= =================================================
+0 Continue operation. This is the default behavior.
+1 Panic immediately.
+= =================================================
 
 
-hung_task_check_count:
-======================
+hung_task_check_count
+=====================
 
 The upper bound on the number of tasks that are checked.
-This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
+This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
 
-hung_task_timeout_secs:
-=======================
+hung_task_timeout_secs
+======================
 
 When a task in D state did not get scheduled
 for more than this value report a warning.
-This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
+This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
-0: means infinite timeout - no checking done.
+0 means infinite timeout, no checking is done.
 
-Possible values to set are in range {0..LONG_MAX/HZ}.
+Possible values to set are in range {0:``LONG_MAX``/``HZ``}.
 
 
-hung_task_check_interval_secs:
-==============================
+hung_task_check_interval_secs
+=============================
 
 Hung task check interval. If hung task checking is enabled
-(see hung_task_timeout_secs), the check is done every
-hung_task_check_interval_secs seconds.
-This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
+(see `hung_task_timeout_secs`_), the check is done every
+``hung_task_check_interval_secs`` seconds.
+This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
-0 (default): means use hung_task_timeout_secs as checking interval.
-Possible values to set are in range {0..LONG_MAX/HZ}.
+0 (default) means use ``hung_task_timeout_secs`` as checking
+interval.
 
+Possible values to set are in range {0:``LONG_MAX``/``HZ``}.
 
-hung_task_warnings:
-===================
+
+hung_task_warnings
+==================
 
 The maximum number of warnings to report. During a check interval
 if a hung task is detected, this value is decreased by 1.
 When this value reaches 0, no more warnings will be reported.
-This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
+This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
 -1: report an infinite number of warnings.
 
 
-hyperv_record_panic_msg:
-========================
+hyperv_record_panic_msg
+=======================
 
 Controls whether the panic kmsg data should be reported to Hyper-V.
 
-0: do not report panic kmsg data.
-
-1: report the panic kmsg data. This is the default behavior.
+= =========================================================
+0 Do not report panic kmsg data.
+1 Report the panic kmsg data. This is the default behavior.
+= =========================================================
 
 
-kexec_load_disabled:
-====================
+kexec_load_disabled
+===================
 
-A toggle indicating if the kexec_load syscall has been disabled. This
-value defaults to 0 (false: kexec_load enabled), but can be set to 1
-(true: kexec_load disabled). Once true, kexec can no longer be used, and
-the toggle cannot be set back to false. This allows a kexec image to be
-loaded before disabling the syscall, allowing a system to set up (and
-later use) an image without it being altered. Generally used together
-with the "modules_disabled" sysctl.
+A toggle indicating if the ``kexec_load`` syscall has been disabled.
+This value defaults to 0 (false: ``kexec_load`` enabled), but can be
+set to 1 (true: ``kexec_load`` disabled).
+Once true, kexec can no longer be used, and the toggle cannot be set
+back to false.
+This allows a kexec image to be loaded before disabling the syscall,
+allowing a system to set up (and later use) an image without it being
+altered.
+Generally used together with the `modules_disabled`_ sysctl.
 
 
-kptr_restrict:
-==============
+kptr_restrict
+=============
 
 This toggle indicates whether restrictions are placed on
-exposing kernel addresses via /proc and other interfaces.
-
-When kptr_restrict is set to 0 (the default) the address is hashed before
-printing. (This is the equivalent to %p.)
-
-When kptr_restrict is set to (1), kernel pointers printed using the %pK
-format specifier will be replaced with 0's unless the user has CAP_SYSLOG
-and effective user and group ids are equal to the real ids. This is
-because %pK checks are done at read() time rather than open() time, so
-if permissions are elevated between the open() and the read() (e.g via
-a setuid binary) then %pK will not leak kernel pointers to unprivileged
-users. Note, this is a temporary solution only. The correct long-term
-solution is to do the permission checks at open() time. Consider removing
-world read permissions from files that use %pK, and using dmesg_restrict
-to protect against uses of %pK in dmesg(8) if leaking kernel pointer
-values to unprivileged users is a concern.
+exposing kernel addresses via ``/proc`` and other interfaces.
+
+When ``kptr_restrict`` is set to 0 (the default) the address is hashed
+before printing.
+(This is the equivalent to %p.)
+
+When ``kptr_restrict`` is set to 1, kernel pointers printed using the
+%pK format specifier will be replaced with 0s unless the user has
+``CAP_SYSLOG`` and effective user and group ids are equal to the real
+ids.
+This is because %pK checks are done at read() time rather than open()
+time, so if permissions are elevated between the open() and the read()
+(e.g via a setuid binary) then %pK will not leak kernel pointers to
+unprivileged users.
+Note, this is a temporary solution only.
+The correct long-term solution is to do the permission checks at
+open() time.
+Consider removing world read permissions from files that use %pK, and
+using `dmesg_restrict`_ to protect against uses of %pK in ``dmesg(8)``
+if leaking kernel pointer values to unprivileged users is a concern.
+
+When ``kptr_restrict`` is set to 2, kernel pointers printed using
+%pK will be replaced with 0s regardless of privileges.
+
+
+l2cr (PPC only)
+===============
 
-When kptr_restrict is set to (2), kernel pointers printed using
-%pK will be replaced with 0's regardless of privileges.
+This flag controls the L2 cache of G3 processor boards. If
+0, the cache is disabled. Enabled if nonzero.
 
 
-l2cr: (PPC only)
-================
+modprobe
+========
 
-This flag controls the L2 cache of G3 processor boards. If
-0, the cache is disabled. Enabled if nonzero.
+See Documentation/debugging-modules.txt.
 
 
-modules_disabled:
-=================
+modules_disabled
+================
 
 A toggle value indicating if modules are allowed to be loaded
 in an otherwise modular kernel.  This toggle defaults to off
 (0), but can be set true (1).  Once true, modules can be
 neither loaded nor unloaded, and the toggle cannot be set back
-to false.  Generally used with the "kexec_load_disabled" toggle.
+to false.  Generally used with the `kexec_load_disabled`_ toggle.
+
+
+.. _msgmni:
+
+msgmax, msgmnb, and msgmni
+==========================
 
 
-msg_next_id, sem_next_id, and shm_next_id:
-==========================================
+msg_next_id, sem_next_id, and shm_next_id (System V IPC)
+========================================================
 
 These three toggles allows to specify desired id for next allocated IPC
 object: message, semaphore or shared memory respectively.
 
 By default they are equal to -1, which means generic allocation logic.
-Possible values to set are in range {0..INT_MAX}.
+Possible values to set are in range {0:``INT_MAX``}.
 
 Notes:
   1) kernel doesn't guarantee, that new object will have desired id. So,
@@ -472,15 +424,16 @@ Notes:
      fails, it is undefined if the value remains unmodified or is reset to -1.
 
 
-nmi_watchdog:
-=============
+nmi_watchdog
+============
 
 This parameter can be used to control the NMI watchdog
 (i.e. the hard lockup detector) on x86 systems.
 
-0 - disable the hard lockup detector
-
-1 - enable the hard lockup detector
+= =================================
+0 Disable the hard lockup detector.
+1 Enable the hard lockup detector.
+= =================================
 
 The hard lockup detector monitors each CPU for its ability to respond to
 timer interrupts. The mechanism utilizes CPU performance counter registers
@@ -492,11 +445,11 @@ in a KVM virtual machine. This default can be overridden by adding::
 
    nmi_watchdog=1
 
-to the guest kernel command line (see Documentation/admin-guide/kernel-parameters.rst).
+to the guest kernel command line (see :doc:`/admin-guide/kernel-parameters`).
 
 
-numa_balancing:
-===============
+numa_balancing
+==============
 
 Enables/disables automatic page fault based NUMA memory
 balancing. Memory is moved automatically to nodes
@@ -514,9 +467,10 @@ ideally is offset by improved memory locality but there is no universal
 guarantee. If the target workload is already bound to NUMA nodes then this
 feature should be disabled. Otherwise, if the system overhead from the
 feature is too high then the rate the kernel samples for NUMA hinting
-faults may be controlled by the numa_balancing_scan_period_min_ms,
+faults may be controlled by the `numa_balancing_scan_period_min_ms,
 numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
-numa_balancing_scan_size_mb, and numa_balancing_settle_count sysctls.
+numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls.
+
 
 numa_balancing_scan_period_min_ms, numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms, numa_balancing_scan_size_mb
 ===============================================================================================================================
@@ -542,23 +496,23 @@ workload pattern changes and minimises performance impact due to remote
 memory accesses. These sysctls control the thresholds for scan delays and
 the number of pages scanned.
 
-numa_balancing_scan_period_min_ms is the minimum time in milliseconds to
+``numa_balancing_scan_period_min_ms`` is the minimum time in milliseconds to
 scan a tasks virtual memory. It effectively controls the maximum scanning
 rate for each task.
 
-numa_balancing_scan_delay_ms is the starting "scan delay" used for a task
+``numa_balancing_scan_delay_ms`` is the starting "scan delay" used for a task
 when it initially forks.
 
-numa_balancing_scan_period_max_ms is the maximum time in milliseconds to
+``numa_balancing_scan_period_max_ms`` is the maximum time in milliseconds to
 scan a tasks virtual memory. It effectively controls the minimum scanning
 rate for each task.
 
-numa_balancing_scan_size_mb is how many megabytes worth of pages are
+``numa_balancing_scan_size_mb`` is how many megabytes worth of pages are
 scanned for a given scan.
 
 
-osrelease, ostype & version:
-============================
+osrelease, ostype & version
+===========================
 
 ::
 
@@ -569,15 +523,16 @@ osrelease, ostype & version:
   # cat version
   #5 Wed Feb 25 21:49:24 MET 1998
 
-The files osrelease and ostype should be clear enough. Version
+The files ``osrelease`` and ``ostype`` should be clear enough.
+``version``
 needs a little more clarification however. The '#5' means that
 this is the fifth kernel built from this source base and the
 date behind it indicates the time the kernel was built.
 The only way to tune these values is to rebuild the kernel :-)
 
 
-overflowgid & overflowuid:
-==========================
+overflowgid & overflowuid
+=========================
 
 if your architecture did not always support 32-bit UIDs (i.e. arm,
 i386, m68k, sh, and sparc32), a fixed UID and GID will be returned to
@@ -588,108 +543,113 @@ These sysctls allow you to change the value of the fixed UID and GID.
 The default is 65534.
 
 
-panic:
-======
+panic
+=====
 
 The value in this file represents the number of seconds the kernel
 waits before rebooting on a panic. When you use the software watchdog,
 the recommended setting is 60.
 
 
-panic_on_io_nmi:
-================
+panic_on_io_nmi
+===============
 
 Controls the kernel's behavior when a CPU receives an NMI caused by
 an IO error.
 
-0: try to continue operation (default)
+= ==================================================================
+0 Try to continue operation (default).
+1 Panic immediately. The IO error triggered an NMI. This indicates a
+  serious system condition which could result in IO data corruption.
+  Rather than continuing, panicking might be a better choice. Some
+  servers issue this sort of NMI when the dump button is pushed,
+  and you can use this option to take a crash dump.
+= ==================================================================
 
-1: panic immediately. The IO error triggered an NMI. This indicates a
-   serious system condition which could result in IO data corruption.
-   Rather than continuing, panicking might be a better choice. Some
-   servers issue this sort of NMI when the dump button is pushed,
-   and you can use this option to take a crash dump.
 
-
-panic_on_oops:
-==============
+panic_on_oops
+=============
 
 Controls the kernel's behaviour when an oops or BUG is encountered.
 
-0: try to continue operation
+= ===================================================================
+0 Try to continue operation.
+1 Panic immediately.  If the `panic` sysctl is also non-zero then the
+  machine will be rebooted.
+= ===================================================================
 
-1: panic immediately.  If the `panic` sysctl is also non-zero then the
-   machine will be rebooted.
 
-
-panic_on_stackoverflow:
-=======================
+panic_on_stackoverflow
+======================
 
 Controls the kernel's behavior when detecting the overflows of
 kernel, IRQ and exception stacks except a user stack.
-This file shows up if CONFIG_DEBUG_STACKOVERFLOW is enabled.
+This file shows up if ``CONFIG_DEBUG_STACKOVERFLOW`` is enabled.
 
-0: try to continue operation.
+= ==========================
+0 Try to continue operation.
+1 Panic immediately.
+= ==========================
 
-1: panic immediately.
 
-
-panic_on_unrecovered_nmi:
-=========================
+panic_on_unrecovered_nmi
+========================
 
 The default Linux behaviour on an NMI of either memory or unknown is
 to continue operation. For many environments such as scientific
 computing it is preferable that the box is taken out and the error
 dealt with than an uncorrected parity/ECC error get propagated.
 
-A small number of systems do generate NMI's for bizarre random reasons
+A small number of systems do generate NMIs for bizarre random reasons
 such as power management so the default is off. That sysctl works like
 the existing panic controls already in that directory.
 
 
-panic_on_warn:
-==============
+panic_on_warn
+=============
 
 Calls panic() in the WARN() path when set to 1.  This is useful to avoid
 a kernel rebuild when attempting to kdump at the location of a WARN().
 
-0: only WARN(), default behaviour.
+= ================================================
+0 Only WARN(), default behaviour.
+1 Call panic() after printing out WARN() location.
+= ================================================
 
-1: call panic() after printing out WARN() location.
 
-
-panic_print:
-============
+panic_print
+===========
 
 Bitmask for printing system info when panic happens. User can chose
 combination of the following bits:
 
-=====  ========================================
+=====  ============================================
 bit 0  print all tasks info
 bit 1  print system memory info
 bit 2  print timer info
-bit 3  print locks info if CONFIG_LOCKDEP is on
+bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
 bit 4  print ftrace buffer
-=====  ========================================
+=====  ============================================
 
 So for example to print tasks and memory info on panic, user can::
 
   echo 3 > /proc/sys/kernel/panic_print
 
 
-panic_on_rcu_stall:
-===================
+panic_on_rcu_stall
+==================
 
 When set to 1, calls panic() after RCU stall detection messages. This
 is useful to define the root cause of RCU stalls using a vmcore.
 
-0: do not panic() when RCU stall takes place, default behavior.
-
-1: panic() after printing RCU stall messages.
+= ============================================================
+0 Do not panic() when RCU stall takes place, default behavior.
+1 panic() after printing RCU stall messages.
+= ============================================================
 
 
-perf_cpu_time_max_percent:
-==========================
+perf_cpu_time_max_percent
+=========================
 
 Hints to the kernel how much CPU time it should be allowed to
 use to handle perf sampling events.  If the perf subsystem
@@ -702,171 +662,179 @@ unexpectedly take too long to execute, the NMIs can become
 stacked up next to each other so much that nothing else is
 allowed to execute.
 
-0:
-   disable the mechanism.  Do not monitor or correct perf's
-   sampling rate no matter how CPU time it takes.
+===== ========================================================
+0     Disable the mechanism.  Do not monitor or correct perf's
+      sampling rate no matter how CPU time it takes.
 
-1-100:
-   attempt to throttle perf's sample rate to this
-   percentage of CPU.  Note: the kernel calculates an
-   "expected" length of each sample event.  100 here means
-   100% of that expected length.  Even if this is set to
-   100, you may still see sample throttling if this
-   length is exceeded.  Set to 0 if you truly do not care
-   how much CPU is consumed.
+1-100 Attempt to throttle perf's sample rate to this
+      percentage of CPU.  Note: the kernel calculates an
+      "expected" length of each sample event.  100 here means
+      100% of that expected length.  Even if this is set to
+      100, you may still see sample throttling if this
+      length is exceeded.  Set to 0 if you truly do not care
+      how much CPU is consumed.
+===== ========================================================
 
 
-perf_event_paranoid:
-====================
+perf_event_paranoid
+===================
 
 Controls use of the performance events system by unprivileged
 users (without CAP_SYS_ADMIN).  The default value is 2.
 
 ===  ==================================================================
- -1  Allow use of (almost) all events by all users
+ -1  Allow use of (almost) all events by all users.
 
-     Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
+     Ignore mlock limit after perf_event_mlock_kb without
+     ``CAP_IPC_LOCK``.
 
->=0  Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
+>=0  Disallow ftrace function tracepoint by users without
+     ``CAP_SYS_ADMIN``.
 
-     Disallow raw tracepoint access by users without CAP_SYS_ADMIN
+     Disallow raw tracepoint access by users without ``CAP_SYS_ADMIN``.
 
->=1  Disallow CPU event access by users without CAP_SYS_ADMIN
+>=1  Disallow CPU event access by users without ``CAP_SYS_ADMIN``.
 
->=2  Disallow kernel profiling by users without CAP_SYS_ADMIN
+>=2  Disallow kernel profiling by users without ``CAP_SYS_ADMIN``.
 ===  ==================================================================
 
 
-perf_event_max_stack:
-=====================
+perf_event_max_stack
+====================
 
-Controls maximum number of stack frames to copy for (attr.sample_type &
-PERF_SAMPLE_CALLCHAIN) configured events, for instance, when using
-'perf record -g' or 'perf trace --call-graph fp'.
+Controls maximum number of stack frames to copy for (``attr.sample_type &
+PERF_SAMPLE_CALLCHAIN``) configured events, for instance, when using
+'``perf record -g``' or '``perf trace --call-graph fp``'.
 
 This can only be done when no events are in use that have callchains
-enabled, otherwise writing to this file will return -EBUSY.
+enabled, otherwise writing to this file will return ``-EBUSY``.
 
 The default value is 127.
 
 
-perf_event_mlock_kb:
-====================
+perf_event_mlock_kb
+===================
 
 Control size of per-cpu ring buffer not counted agains mlock limit.
 
 The default value is 512 + 1 page
 
 
-perf_event_max_contexts_per_stack:
-==================================
+perf_event_max_contexts_per_stack
+=================================
 
 Controls maximum number of stack frame context entries for
-(attr.sample_type & PERF_SAMPLE_CALLCHAIN) configured events, for
-instance, when using 'perf record -g' or 'perf trace --call-graph fp'.
+(``attr.sample_type & PERF_SAMPLE_CALLCHAIN``) configured events, for
+instance, when using '``perf record -g``' or '``perf trace --call-graph fp``'.
 
 This can only be done when no events are in use that have callchains
-enabled, otherwise writing to this file will return -EBUSY.
+enabled, otherwise writing to this file will return ``-EBUSY``.
 
 The default value is 8.
 
 
-pid_max:
-========
+pid_max
+=======
 
 PID allocation wrap value.  When the kernel's next PID value
 reaches this value, it wraps back to a minimum PID value.
-PIDs of value pid_max or larger are not allocated.
+PIDs of value ``pid_max`` or larger are not allocated.
 
 
-ns_last_pid:
-============
+ns_last_pid
+===========
 
 The last pid allocated in the current (the one task using this sysctl
 lives in) pid namespace. When selecting a pid for a next task on fork
 kernel tries to allocate a number starting from this one.
 
 
-powersave-nap: (PPC only)
-=========================
+powersave-nap (PPC only)
+========================
 
 If set, Linux-PPC will use the 'nap' mode of powersaving,
 otherwise the 'doze' mode will be used.
 
+
 ==============================================================
 
-printk:
-=======
+printk
+======
 
-The four values in printk denote: console_loglevel,
-default_message_loglevel, minimum_console_loglevel and
-default_console_loglevel respectively.
+The four values in printk denote: ``console_loglevel``,
+``default_message_loglevel``, ``minimum_console_loglevel`` and
+``default_console_loglevel`` respectively.
 
 These values influence printk() behavior when printing or
-logging error messages. See 'man 2 syslog' for more info on
+logging error messages. See '``man 2 syslog``' for more info on
 the different loglevels.
 
-- console_loglevel:
-	messages with a higher priority than
-	this will be printed to the console
-- default_message_loglevel:
-	messages without an explicit priority
-	will be printed with this priority
-- minimum_console_loglevel:
-	minimum (highest) value to which
-	console_loglevel can be set
-- default_console_loglevel:
-	default value for console_loglevel
+======================== =====================================
+console_loglevel         messages with a higher priority than
+                         this will be printed to the console
+default_message_loglevel messages without an explicit priority
+                         will be printed with this priority
+minimum_console_loglevel minimum (highest) value to which
+                         console_loglevel can be set
+default_console_loglevel default value for console_loglevel
+======================== =====================================
 
 
-printk_delay:
-=============
+printk_delay
+============
 
-Delay each printk message in printk_delay milliseconds
+Delay each printk message in ``printk_delay`` milliseconds
 
 Value from 0 - 10000 is allowed.
 
 
-printk_ratelimit:
-=================
+printk_ratelimit
+================
 
-Some warning messages are rate limited. printk_ratelimit specifies
+Some warning messages are rate limited. ``printk_ratelimit`` specifies
 the minimum length of time between these messages (in seconds).
 The default value is 5 seconds.
 
 A value of 0 will disable rate limiting.
 
 
-printk_ratelimit_burst:
-=======================
+printk_ratelimit_burst
+======================
 
-While long term we enforce one message per printk_ratelimit
+While long term we enforce one message per `printk_ratelimit`_
 seconds, we do allow a burst of messages to pass through.
-printk_ratelimit_burst specifies the number of messages we can
+``printk_ratelimit_burst`` specifies the number of messages we can
 send before ratelimiting kicks in.
 
 The default value is 10 messages.
 
 
-printk_devkmsg:
-===============
-
-Control the logging to /dev/kmsg from userspace:
-
-ratelimit:
-	default, ratelimited
+printk_devkmsg
+==============
 
-on: unlimited logging to /dev/kmsg from userspace
+Control the logging to ``/dev/kmsg`` from userspace:
 
-off: logging to /dev/kmsg disabled
+========= =============================================
+ratelimit default, ratelimited
+on        unlimited logging to /dev/kmsg from userspace
+off       logging to /dev/kmsg disabled
+========= =============================================
 
-The kernel command line parameter printk.devkmsg= overrides this and is
+The kernel command line parameter ``printk.devkmsg=`` overrides this and is
 a one-time setting until next reboot: once set, it cannot be changed by
 this sysctl interface anymore.
 
+==============================================================
 
-randomize_va_space:
-===================
+
+pty
+===
+
+See Documentation/filesystems/devpts.txt.
+
+
+randomize_va_space
+==================
 
 This option can be used to select the type of process address
 space randomization that is used in the system, for architectures
@@ -881,10 +849,10 @@ that support this feature.
     This, among other things, implies that shared libraries will be
     loaded to random addresses.  Also for PIE-linked binaries, the
     location of code start is randomized.  This is the default if the
-    CONFIG_COMPAT_BRK option is enabled.
+    ``CONFIG_COMPAT_BRK`` option is enabled.
 
 2   Additionally enable heap randomization.  This is the default if
-    CONFIG_COMPAT_BRK is disabled.
+    ``CONFIG_COMPAT_BRK`` is disabled.
 
     There are a few legacy applications out there (such as some ancient
     versions of libc.so.5 from 1996) that assume that brk area starts
@@ -894,21 +862,27 @@ that support this feature.
     systems it is safe to choose full randomization.
 
     Systems with ancient and/or broken binaries should be configured
-    with CONFIG_COMPAT_BRK enabled, which excludes the heap from process
+    with ``CONFIG_COMPAT_BRK`` enabled, which excludes the heap from process
     address space randomization.
 ==  ===========================================================================
 
 
-reboot-cmd: (Sparc only)
-========================
+real-root-dev
+=============
+
+See :doc:`/admin-guide/initrd`.
+
+
+reboot-cmd (SPARC only)
+=======================
 
 ??? This seems to be a way to give an argument to the Sparc
 ROM/Flash boot loader. Maybe to tell it what to do after
 rebooting. ???
 
 
-rtsig-max & rtsig-nr:
-=====================
+rtsig-max & rtsig-nr
+====================
 
 The file rtsig-max can be used to tune the maximum number
 of POSIX realtime (queued) signals that can be outstanding
@@ -917,8 +891,8 @@ in the system.
 rtsig-nr shows the number of RT signals currently queued.
 
 
-sched_energy_aware:
-===================
+sched_energy_aware
+==================
 
 Enables/disables Energy Aware Scheduling (EAS). EAS starts
 automatically on platforms where it can run (that is,
@@ -928,75 +902,85 @@ requirements for EAS but you do not want to use it, change
 this value to 0.
 
 
-sched_schedstats:
-=================
+sched_schedstats
+================
 
 Enables/disables scheduler statistics. Enabling this feature
 incurs a small amount of overhead in the scheduler but is
 useful for debugging and performance tuning.
 
 
-sg-big-buff:
-============
+seccomp
+=======
+
+See :doc:`/userspace-api/seccomp_filter`.
+
+
+sg-big-buff
+===========
 
 This file shows the size of the generic SCSI (sg) buffer.
 You can't tune it just yet, but you could change it on
-compile time by editing include/scsi/sg.h and changing
-the value of SG_BIG_BUFF.
+compile time by editing ``include/scsi/sg.h`` and changing
+the value of ``SG_BIG_BUFF``.
 
 There shouldn't be any reason to change this value. If
 you can come up with one, you probably know what you
 are doing anyway :)
 
 
-shmall:
-=======
+shmall
+======
 
 This parameter sets the total amount of shared memory pages that
-can be used system wide. Hence, SHMALL should always be at least
-ceil(shmmax/PAGE_SIZE).
+can be used system wide. Hence, ``shmall`` should always be at least
+``ceil(shmmax/PAGE_SIZE)``.
 
-If you are not sure what the default PAGE_SIZE is on your Linux
-system, you can run the following command:
+If you are not sure what the default ``PAGE_SIZE`` is on your Linux
+system, you can run the following command::
 
 	# getconf PAGE_SIZE
 
 
-shmmax:
-=======
+shmmax
+======
 
 This value can be used to query and set the run time limit
 on the maximum shared memory segment size that can be created.
 Shared memory segments up to 1Gb are now supported in the
-kernel.  This value defaults to SHMMAX.
+kernel.  This value defaults to ``SHMMAX``.
 
 
-shm_rmid_forced:
-================
+shmmni
+======
+
+
+shm_rmid_forced
+===============
 
 Linux lets you set resource limits, including how much memory one
-process can consume, via setrlimit(2).  Unfortunately, shared memory
+process can consume, via ``setrlimit(2)``.  Unfortunately, shared memory
 segments are allowed to exist without association with any process, and
 thus might not be counted against any resource limits.  If enabled,
 shared memory segments are automatically destroyed when their attach
 count becomes zero after a detach or a process termination.  It will
 also destroy segments that were created, but never attached to, on exit
-from the process.  The only use left for IPC_RMID is to immediately
+from the process.  The only use left for ``IPC_RMID`` is to immediately
 destroy an unattached segment.  Of course, this breaks the way things are
 defined, so some applications might stop working.  Note that this
 feature will do you no good unless you also configure your resource
-limits (in particular, RLIMIT_AS and RLIMIT_NPROC).  Most systems don't
+limits (in particular, ``RLIMIT_AS`` and ``RLIMIT_NPROC``).  Most systems don't
 need this.
 
 Note that if you change this from 0 to 1, already created segments
 without users and with a dead originative process will be destroyed.
 
 
-sysctl_writes_strict:
-=====================
+sysctl_writes_strict
+====================
 
 Control how file position affects the behavior of updating sysctl values
-via the /proc/sys interface:
+via the ``/proc/sys`` interface:
 
   ==   ======================================================================
   -1   Legacy per-write sysctl value handling, with no printk warnings.
@@ -1013,8 +997,8 @@ via the /proc/sys interface:
   ==   ======================================================================
 
 
-softlockup_all_cpu_backtrace:
-=============================
+softlockup_all_cpu_backtrace
+============================
 
 This value controls the soft lockup detector thread's behavior
 when a soft lockup condition is detected as to whether or not
@@ -1024,43 +1008,56 @@ be issued an NMI and instructed to capture stack trace.
 This feature is only applicable for architectures which support
 NMI.
 
-0: do nothing. This is the default behavior.
-
-1: on detection capture more debug information.
+= ============================================
+0 Do nothing. This is the default behavior.
+1 On detection capture more debug information.
+= ============================================
 
 
-soft_watchdog:
-==============
+soft_watchdog
+=============
 
 This parameter can be used to control the soft lockup detector.
 
-   0 - disable the soft lockup detector
-
-   1 - enable the soft lockup detector
+= =================================
+0 Disable the soft lockup detector.
+1 Enable the soft lockup detector.
+= =================================
 
 The soft lockup detector monitors CPUs for threads that are hogging the CPUs
 without rescheduling voluntarily, and thus prevent the 'watchdog/N' threads
 from running. The mechanism depends on the CPUs ability to respond to timer
 interrupts which are needed for the 'watchdog/N' threads to be woken up by
-the watchdog timer function, otherwise the NMI watchdog - if enabled - can
+the watchdog timer function, otherwise the NMI watchdog — if enabled — can
 detect a hard lockup condition.
 
 
-stack_erasing:
-==============
+stack_erasing
+=============
 
 This parameter can be used to control kernel stack erasing at the end
-of syscalls for kernels built with CONFIG_GCC_PLUGIN_STACKLEAK.
+of syscalls for kernels built with ``CONFIG_GCC_PLUGIN_STACKLEAK``.
 
 That erasing reduces the information which kernel stack leak bugs
 can reveal and blocks some uninitialized stack variable attacks.
 The tradeoff is the performance impact: on a single CPU system kernel
 compilation sees a 1% slowdown, other systems and workloads may vary.
 
-  0: kernel stack erasing is disabled, STACKLEAK_METRICS are not updated.
+= ====================================================================
+0 Kernel stack erasing is disabled, STACKLEAK_METRICS are not updated.
+1 Kernel stack erasing is enabled (default), it is performed before
+  returning to the userspace at the end of syscalls.
+= ====================================================================
+
+
+stop-a (SPARC only)
+===================
 
-  1: kernel stack erasing is enabled (default), it is performed before
-     returning to the userspace at the end of syscalls.
+
+sysrq
+=====
+
+See :doc:`/admin-guide/sysrq`.
 
 
 tainted
@@ -1090,30 +1087,30 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
 131072  `(T)`  The kernel was built with the struct randomization plugin
 ======  =====  ==============================================================
 
-See Documentation/admin-guide/tainted-kernels.rst for more information.
+See :doc:`/admin-guide/tainted-kernels` for more information.
 
 
-threads-max:
-============
+threads-max
+===========
 
 This value controls the maximum number of threads that can be created
-using fork().
+using ``fork()``.
 
 During initialization the kernel sets this value such that even if the
 maximum number of threads is created, the thread structures occupy only
 a part (1/8th) of the available RAM pages.
 
-The minimum value that can be written to threads-max is 1.
+The minimum value that can be written to ``threads-max`` is 1.
 
-The maximum value that can be written to threads-max is given by the
-constant FUTEX_TID_MASK (0x3fffffff).
+The maximum value that can be written to ``threads-max`` is given by the
+constant ``FUTEX_TID_MASK`` (0x3fffffff).
 
-If a value outside of this range is written to threads-max an error
-EINVAL occurs.
+If a value outside of this range is written to ``threads-max`` an
+``EINVAL`` error occurs.
 
 
-unknown_nmi_panic:
-==================
+unknown_nmi_panic
+=================
 
 The value in this file affects behavior of handling NMI. When the
 value is non-zero, unknown NMI is trapped and then panic occurs. At
@@ -1123,37 +1120,39 @@ NMI switch that most IA32 servers have fires unknown NMI up, for
 example.  If a system hangs up, try pressing the NMI switch.
 
 
-watchdog:
-=========
+watchdog
+========
 
 This parameter can be used to disable or enable the soft lockup detector
-_and_ the NMI watchdog (i.e. the hard lockup detector) at the same time.
+*and* the NMI watchdog (i.e. the hard lockup detector) at the same time.
 
-   0 - disable both lockup detectors
-
-   1 - enable both lockup detectors
+= ==============================
+0 Disable both lockup detectors.
+1 Enable both lockup detectors.
+= ==============================
 
 The soft lockup detector and the NMI watchdog can also be disabled or
-enabled individually, using the soft_watchdog and nmi_watchdog parameters.
-If the watchdog parameter is read, for example by executing::
+enabled individually, using the ``soft_watchdog`` and ``nmi_watchdog``
+parameters.
+If the ``watchdog`` parameter is read, for example by executing::
 
    cat /proc/sys/kernel/watchdog
 
-the output of this command (0 or 1) shows the logical OR of soft_watchdog
-and nmi_watchdog.
+the output of this command (0 or 1) shows the logical OR of
+``soft_watchdog`` and ``nmi_watchdog``.
 
 
-watchdog_cpumask:
-=================
+watchdog_cpumask
+================
 
 This value can be used to control on which cpus the watchdog may run.
-The default cpumask is all possible cores, but if NO_HZ_FULL is
+The default cpumask is all possible cores, but if ``NO_HZ_FULL`` is
 enabled in the kernel config, and cores are specified with the
-nohz_full= boot argument, those cores are excluded by default.
+``nohz_full=`` boot argument, those cores are excluded by default.
 Offline cores can be included in this mask, and if the core is later
 brought online, the watchdog will be started based on the mask value.
 
-Typically this value would only be touched in the nohz_full case
+Typically this value would only be touched in the ``nohz_full`` case
 to re-enable cores that by default were not running the watchdog,
 if a kernel lockup was suspected on those cores.
 
@@ -1164,12 +1163,12 @@ might say::
   echo 0,2-4 > /proc/sys/kernel/watchdog_cpumask
 
 
-watchdog_thresh:
-================
+watchdog_thresh
+===============
 
 This value can be used to control the frequency of hrtimer and NMI
 events and the soft and hard lockup thresholds. The default threshold
 is 10 seconds.
 
-The softlockup threshold is (2 * watchdog_thresh). Setting this
+The softlockup threshold is (``2 * watchdog_thresh``). Setting this
 tunable to zero will disable lockup detection altogether.
-- 
2.24.1

